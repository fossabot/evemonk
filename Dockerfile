FROM ruby:2.6.5-slim

LABEL maintainer="Igor Zubkov <igor.zubkov@gmail.com>"

RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install gnupg2 git gcc g++ make wget curl wait-for-it libpq-dev libjemalloc2 --no-install-recommends -y

RUN sh -c 'curl -sL https://deb.nodesource.com/setup_12.x | bash -'

RUN sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'

RUN sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'

RUN apt-get update -y && \
    apt-get install nodejs yarn --no-install-recommends -y

RUN apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV production

ENV RUBYGEMS_VERSION 3.0.6

RUN gem update --system "$RUBYGEMS_VERSION"

ENV BUNDLER_VERSION 2.1.0.pre.3

RUN gem install bundler --version "$BUNDLER_VERSION" --force

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config set --global frozen 1

# two jobs
RUN bundle config set --global jobs 2

# install only production gems without development and test
RUN bundle config set --global without development test

# retry 5 times before fail
RUN bundle config set --global retry 5

RUN bundle install

COPY package.json package.json

COPY yarn.lock yarn.lock

RUN yarn install

COPY . .

RUN bundle exec rake SECRET_KEY_BASE=blablabla DB_ADAPTER=nulldb DATABASE_URL="postgres://postgres@postgresql/evemonk_production?pool=1&encoding=unicode" assets:precompile

ARG COMMIT=""

ENV COMMIT_SHA=${COMMIT}

RUN curl -sL https://sentry.io/get-cli/ | bash

ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.2

EXPOSE 3000

CMD ['rails', 'server', '-b', '0.0.0.0']
