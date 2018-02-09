# frozen_string_literal: true

require('sequel')

APP_ENV = ENV.fetch('APP_ENV') { 'dev' }

url = begin
  vars = [
    ENV['POSTGRES_USER'] || ENV['USER'],
    ENV['POSTGRES_HOST'] || 'db',
    ENV['POSTGRES_PORT'] || '5432',
    ENV['POSTGRES_DB'] || 'alquillar_bot_dev'
  ]

  "postgresql://%s@%s:%s/%s?encoding=utf8&pool=5&timeout=5000" % vars
end

DB = Sequel.connect(url)

DB.extension(:pg_array)

# DB.extension :postgis

# { With loggin }
# DB = Sequel.connect("postgres://user:password@host:port/database_name",
#   max_connections: 10, logger: Logger.new('log/db.log'))
