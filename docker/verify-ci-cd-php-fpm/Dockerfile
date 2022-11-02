# ARGデフォルト値
ARG SRC_CONFIG_DIR_PATH=docker/verify-ci-cd-php-fpm/config
ARG DST_CONFIG_DIR_PATH=/usr/local/etc
ARG DEFAULT_WORK_DIR=/usr/share/nginx/html

# コンテナの設定を行うステージ
FROM php:8-fpm as base

# NOTE: TimeZoneの設定は環境変数の指定と/etc/localtimeのシンボリックリンク上書き両方行うこと
#       （OSによってはTimeZoneの環境変数が反映されないため）
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    procps \
    unzip \
    libssl-dev \
    libsasl2-dev

# 必要なモジュールをインストール
RUN pecl install \
    mongodb-1.14.0

FROM base as local
ARG SRC_CONFIG_DIR_PATH
ARG DST_CONFIG_DIR_PATH

COPY ${SRC_CONFIG_DIR_PATH}/php \
    ${DST_CONFIG_DIR_PATH}/php
COPY ${SRC_CONFIG_DIR_PATH}/php-fpm.d \
    ${DST_CONFIG_DIR_PATH}/php-fpm.d
COPY ${SRC_CONFIG_DIR_PATH}/php-fpm.conf \
    ${DST_CONFIG_DIR_PATH}/php-fpm.conf
