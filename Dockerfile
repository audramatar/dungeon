FROM ruby:2.4.0

MAINTAINER Audra Matar <audramatar@gmail.com>

COPY /lib lib/
COPY /tests tests/
COPY main.rb .
COPY Gemfile .
COPY Rakefile .
RUN /bin/bash -l -c "bundle install --gemfile=./Gemfile"