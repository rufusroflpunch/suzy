require 'fileutils'
require 'sequel'

namespace :db do
  desc 'Create the database'
  task :create do
    conn_string = "postgres://#{App.config.db_user}:#{App.config.db_password}@#{App.config.db_host}:#{App.config.db_port}"
    db = Sequel.connect(conn_string)
    db.run "CREATE DATABASE #{App.config.db_name};"
  end

  desc 'Drop the database'
  task :drop do
    App.db.disconnect
    conn_string = "postgres://#{App.config.db_user}:#{App.config.db_password}@#{App.config.db_host}:#{App.config.db_port}"
    db = Sequel.connect(conn_string)
    db.run "DROP DATABASE #{App.config.db_name};"
  end

  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(App.db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(App.db, "db/migrations")
    end
  end

  desc "Create a new migration"
  task 'migrate:new', [:name] do |t, args|
    ts = Time.now.strftime('%Y%m%d%H%M%S')
    new_file = File.join(App.root, 'db', 'migrations', "#{ts}_#{args[:name] || 'new_migration'}.rb")
    puts "Creating new migration #{File.basename(new_file)}."
    File.open(new_file, 'w+') do |f|
      f.puts "Sequel.migration do"
      f.puts "  up do"
      f.puts "  end"
      f.puts ""
      f.puts "  down do"
      f.puts "  end"
      f.puts "end"
    end
  end
end
