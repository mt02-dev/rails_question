FROM ruby:3.2.2-alpine

RUN apk update

RUN apk add g++ make mysql-dev tzdata

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

# bundle install でGemfileに記述されているgemをインストール
RUN bundle install