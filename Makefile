

IMAGE_OWNER :=
IMAGE_NAME :=
RELEASE_VERSION :=

PAT_GITHUB :=
PAT_DOCKERHUB :=


################################################################################
# Other environment variables
################################################################################
GITHUB_USER = ${IMAGE_OWNER}

IMAGE_NAME_FOR_GHCR = ghcr.io/${GITHUB_USER}/${IMAGE_NAME}
IMAGE_NAME_LATEST_FOR_GHCR = ${IMAGE_NAME_FOR_GHCR}:latest


################################################################################
# イメージビルド・デプロイタスク
################################################################################


# note: 誤操作防止のためtarget指定なしの場合はエラー扱いにする
all:
	@echo Please specify the target
	@exit 1

# NOTE: 手動実行用のタスク（CI/CDではこのtarget内の処理を実行する）
# make deploy-ghcr -e IMAGE_OWNER={} IMAGE_NAME={} PAT_GITHUB={}
deploy-ghcr: build set-tag-ghcr login-ghcr push-ghcr;

# make build -e IMAGE_NAME={}
build:
	docker-compose build --no-cache --force-rm ${IMAGE_NAME}

# make set-tag-ghcr -e IMAGE_OWNER={} IMAGE_NAME={}
set-tag-ghcr:
	docker tag ${IMAGE_NAME} ${IMAGE_NAME_LATEST_FOR_GHCR}

# make login-ghcr -e PAT_GITHUB={} GITHUB_USER={}
login-ghcr:
	@echo ${PAT_GITHUB} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

# make push-ghcr -e IMAGE_OWNER={} IMAGE_NAME={}
push-ghcr:
	docker push ${IMAGE_NAME_LATEST_FOR_GHCR}

################################################################################
# イメージビルド・デプロイタスク（ハードコーディング版）
################################################################################

build-images: build-verify-ci-cd-mongo build-verify-ci-cd-php-fpm;

build-verify-ci-cd-mongo: IMAGE_NAME +=verify-ci-cd-mongo
build-verify-ci-cd-mongo: build;

build-verify-ci-cd-php-fpm: IMAGE_NAME +=verify-ci-cd-php-fpm
build-verify-ci-cd-php-fpm: build;

# make deploy-verify-ci-cd-mongo PAT_GITHUB={}
deploy-verify-ci-cd-mongo: IMAGE_OWNER +=hazuki3417
deploy-verify-ci-cd-mongo: IMAGE_NAME +=verify-ci-cd-mongo
deploy-verify-ci-cd-mongo: deploy-ghcr;

# make deploy-verify-ci-cd-php-fpm PAT_GITHUB={}
deploy-verify-ci-cd-php-fpm: IMAGE_OWNER +=hazuki3417
deploy-verify-ci-cd-php-fpm: IMAGE_NAME +=verify-ci-cd-php-fpm
deploy-verify-ci-cd-php-fpm: deploy-ghcr;
