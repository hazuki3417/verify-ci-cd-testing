# ARGデフォルト値
ARG SRC_CONFIG_DIR_PATH=docker/verify-ci-cd-mongo/config
ARG DST_CONFIG_DIR_PATH=
ARG DEFAULT_WORK_DIR=

# コンテナの設定を行うステージ
FROM mongo:4.0 as base

# NOTE: TimeZoneの設定は環境変数の指定と/etc/localtimeのシンボリックリンク上書き両方行うこと
#       （OSによってはTimeZoneの環境変数が反映されないため）
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja

CMD ["mongod", "--logpath", "/proc/1/fd/1", "--profile=2", "--slowms=1"]

FROM base as local
