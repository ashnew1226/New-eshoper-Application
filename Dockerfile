FROM ruby:3.0.0

RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    mkdir /Eshopper

WORKDIR /Eshopper

COPY Gemfile /Eshopper/Gemfile
COPY Gemfile.lock /Eshopper/Gemfile.lock
RUN bundle install

COPY . /Eshopper
RUN rails db:create
RUN bundle exec rails db:migrate
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]