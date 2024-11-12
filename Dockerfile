# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.3.6

# BASE IMAGE
FROM ruby:$RUBY_VERSION-alpine AS base
ARG CONTAINER_USER_ID
ARG CONTAINER_GROUP_ID
ARG CONTAINER_USER_NAME
ENV CONTAINER_USER_NAME=${CONTAINER_USER_NAME:-app} \
  CONTAINER_USER_ID=${CONTAINER_USER_ID:-1000} \
  CONTAINER_GROUP_ID=${CONTAINER_GROUP_ID:-1000} \
  APP_PATH="/srv/app"

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
RUN apk add --no-cache --update bash

# DEV BUILDER IMAGE
FROM base AS builder_development
COPY Gemfile Gemfile.lock ./
RUN apk add --no-cache --update \
  build-base \
  postgresql-dev \
  git
RUN bundle install --jobs $(nproc) --retry 3 && \
  rm -rf ~/.bundle/ /usr/local/bundle/ruby/*/cache /usr/local/bundle/ruby/*/bundler/gems/*/.git && \
  bundle exec bootsnap precompile --gemfile

## DEVELOPMENT IMAGE
FROM base AS development
ENV RAILS_ENV="development"
RUN apk add --no-cache --update \
  build-base \
  git \
  tzdata \
  nodejs-current \
  sqlite \
  postgresql-client \
  less \
  graphviz \
  ttf-dejavu

RUN corepack enable
RUN addgroup -S -g ${CONTAINER_GROUP_ID} $CONTAINER_USER_NAME && \
  adduser -S -u ${CONTAINER_USER_ID} -g $CONTAINER_USER_NAME -h /home/$CONTAINER_USER_NAME -s /bin/bash $CONTAINER_USER_NAME

# gems
COPY --from=builder_development --chown=${CONTAINER_USER_ID}:${CONTAINER_GROUP_ID} /usr/local/bundle /usr/local/bundle

WORKDIR $APP_PATH
USER $CONTAINER_USER_NAME

# Entrypoint prepares the database and the rest of environment
ENTRYPOINT ["/srv/app/docker/dev/docker-entrypoint.sh"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]











## JEMALLOC IMAGE
FROM base AS builder_jemalloc
RUN apk add --no-cache --update build-base
RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2 | tar -xj && \
  cd jemalloc-5.3.0 && \
  ./configure && \
  make && \
  make install

# BUILDER IMAGE
FROM base AS builder_prod
ENV RAILS_ENV=production \
  NODE_ENV=production \
  BUNDLE_FROZEN="1" \
  BUNDLE_WITHOUT="development"

RUN apk add --no-cache --update \
  build-base \
  bash \
  git \
  tzdata \
  postgresql-dev \
  nodejs-current \
  less
RUN corepack enable

COPY Gemfile Gemfile.lock ./
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3 && \
  rm -rf ~/.bundle/ /usr/local/bundle/ruby/*/cache /usr/local/bundle/ruby/*/bundler/gems/*/.git && \
  bundle exec bootsnap precompile --gemfile

COPY . .
RUN bundle exec bootsnap precompile app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile && \
  rm -r node_modules .yarn

## PRODUCTION IMAGE
FROM base AS production
ENV RAILS_ENV=production \
  NODE_ENV=production \
  BUNDLE_WITHOUT="development" \
  RAILS_SERVE_STATIC_FILES=true \
  RUBY_GC_HEAP_INIT_SLOTS=2000000 \
  RUBY_HEAP_FREE_MIN=20000 \
  RUBY_GC_MALLOC_LIMIT=100000000

COPY --from=builder_prod /usr/local/bundle /usr/local/bundle
COPY --from=builder_prod $APP_PATH $APP_PATH
COPY --from=builder_jemalloc /usr/local/lib/libjemalloc.so.2 /usr/local/lib/

RUN apk add --no-cache --update \
  libpq \
  tzdata

RUN addgroup -S -g ${CONTAINER_GROUP_ID} $CONTAINER_USER_NAME && \
  adduser -S -u ${CONTAINER_USER_ID} -g $CONTAINER_USER_NAME -h /home/$CONTAINER_USER_NAME -s /bin/bash $CONTAINER_USER_NAME && \
  chown $CONTAINER_USER_NAME:$CONTAINER_USER_NAME db log storage tmp

USER $CONTAINER_USER_NAME

# Entrypoint prepares the database.
ENTRYPOINT ["/srv/app/docker/prod/docker-entrypoint.sh"]
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]