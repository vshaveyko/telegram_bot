FROM ruby:2.4.2

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    (curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -)

RUN curl -sS https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update && \
    apt-get install -qq -y nodejs openssh-client build-essential apt-utils libcurl4-openssl-dev libssl-dev libpq-dev postgresql-client-9.6 cron --fix-missing --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV production
ENV RACK_ENV production

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --without development test bot --jobs 4 --retry 3

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
VOLUME ["$INSTALL_PATH"]

COPY . .

EXPOSE 3000

ENTRYPOINT ./bin/entrypoint.sh
