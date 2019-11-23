FROM ruby:2.6.5

RUN apt-get clean && apt-get update && apt-get install -y vim

WORKDIR /videoshowcase
ADD . /videoshowcase

ADD Gemfile* /videoshowcase/
ENV BUNDLE_GEMFILE=/videoshowcase/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN gem install bundler && bundle install
RUN gem install rake
