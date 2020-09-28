FROM ruby:2.7-alpine as development

RUN apk --update add mariadb-dev \
  build-base

WORKDIR /api