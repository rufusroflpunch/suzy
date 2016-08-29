# Require the base app class
require_relative '../app/app.rb'

# Require the gems
require 'bundler'
Bundler.require(:default, App.env)

# Load Sequel extension
require 'sequel/extensions/migration'

# Laod config files
Dir[File.join(App.root, 'config/*.rb')].each do |rb|
  require rb unless rb == File.absolute_path(__FILE__)
end

# Load environment config
require File.join(App.root, "config/environments/#{App.env}.rb")

# Load db and configure Sequel on startup, unless there instructed not to
App.db
begin
  App.db.test_connection
  Sequel::Model.plugin :timestamps, update_on_create: true

  # Load application files
  Dir[File.join(App.root, 'app/**/*.rb')].each do |rb|
    require rb
  end

  # Load initializers
  Dir[File.join(App.root, 'config/initializers/*.rb')].each do |rb|
    require rb
  end

rescue Sequel::DatabaseConnectionError
  # The Rakefile loads the full environment on startup. This includes the db:create task. However, we don't want
  # the environment crashing on startup because the database doesn't exist yet before db:create is run.
  # If the server is started before running db:create, it will still crash at a later time in the loading process
  # with a helpful error message. See config.ru for that message.
end
