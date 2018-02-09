# frozen_string_literal: true

source('https://rubygems.org')

ruby('2.4.2')

gem 'rake'

# working with http external API's
gem('httparty')

# Background workers
# gem('sidekiq')
# JSON parser
gem('oj')

# cron tasks
# gem('whenever', require: false)

# testing
group :test do
  gem('database_cleaner')
  gem('rspec')
  gem('webmock')
end

group :development, :test do
  # debug
  gem('debbie')
  # gem 'pry-stack_explorer'
end

# db adapter
gem('pg')
gem('sequel')

# manage .env file
gem('dotenv')
#
# Telegram integration
gem('telegram-bot-ruby')

# Parsing progress bar
gem('ruby-progressbar')
