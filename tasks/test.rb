def check_env
  unless App.env == :test
    puts 'Please set SUZY_ENV=test prior to running tests to ensure test environment is loaded correctly.'
    exit
  end
end

def check_migrations
  unless Sequel::Migrator.is_current?(App.db, File.join(App.root, 'db', 'migrations'))
    puts 'Please run migrations.'
    exit
  end
end

desc "Run the tests"
task :test do
  check_env
  check_migrations
  puts 'Tests!'
  # TODO: Run tests
end
