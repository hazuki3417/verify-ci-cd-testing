# note: 誤操作防止のためtarget指定なしの場合はエラー扱いにする
all:
	@echo Please specify the target
	@exit 1

build-images: build-verify-ci-cd-mongo build-verify-ci-cd-php-fpm;

build-verify-ci-cd-mongo:
	docker build -t verify-ci-cd-mongo:latest -f docker/verify-ci-cd-mongo/Dockerfile .

build-verify-ci-cd-php-fpm:
	docker build -t verify-ci-cd-php-fpm:latest -f docker/verify-ci-cd-php-fpm/Dockerfile .
