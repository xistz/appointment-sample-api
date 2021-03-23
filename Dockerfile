FROM ruby:2.7-alpine as base

RUN apk --update add mariadb-dev \
  build-base \
  tzdata

ENV TZ=UTC

WORKDIR /api

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle config set no-cache 'true'

FROM base as development

RUN bundle install --jobs 4 \
  --retry 3

FROM base as builder

RUN bundle install --jobs 4 \
  --retry 3 \
  --without development test

COPY . .

FROM ruby:2.7-alpine as release

RUN apk --update add mariadb-dev \
  tzdata

ENV TZ=UTC

RUN addgroup -S money_forward 
RUN adduser -S appointment -G money_forward

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=appointment:money_forward /api /api

USER appointment

WORKDIR /api

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]