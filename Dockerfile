FROM ruby:2.6.5-alpine3.11

WORKDIR /web

COPY ./Gemfile .

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update --no-cache \
    && apk add --no-cache --virtual .build-deps build-base \
    && apk add --no-cache git \
    # && gem sources --remove https://rubygems.org/ \
    # && gem sources -a https://mirrors.aliyun.com/rubygems/ \
    && gem install bundler \
    && bundle install
    # && apk del -f .build-deps

# CMD ["bundle", "exec", "jekyll", "build"]
