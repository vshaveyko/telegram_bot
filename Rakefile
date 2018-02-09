# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require_relative('config/database')

namespace(:db) do

  def current_schema_version
    if DB.tables.include?(:schema_info)
      DB[:schema_info].first[:version]
    else
      0
    end
  end

  def migrate_to(version: nil)
    puts(version ? "Migrating to version #{version}..." : 'Migrating...')
    opts = version ? { target: version.to_i } : {}

    Sequel.extension(:migration)
    Sequel::Migrator.run(DB, 'db/migrations', opts)
  end

  desc('Run migrations')
  task(:migrate, [:version]) do |_t, args|
    migrate_to(version: args[:version])
  end
  #
  # desc "Rollback migrations"
  # task :rollback, [:step] do |t, args|
  #   args.with_defaults(step: 1)
  #
  #   p
  #   migrate_to(version: )
  # end
end

namespace(:features) do
  task(:load) do
    require('timeout')
    require_relative('config/boot')

    DB[:alquillar_features].truncate(cascade: true, restart: true)

    Timeout.timeout(120) do
      begin
        Lunua::Crawler.new.call
      rescue Oj::ParseError
        puts('Crawler error, retrying...')
        retry
      end
    end
  end

  task(:preload) do
    if DB[:alquillar_features].count == 0
      Rake::Task["features:load"].execute
    end
  end
end
