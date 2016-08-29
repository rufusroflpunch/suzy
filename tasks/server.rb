desc "Start up the server"
task :server do
  if App.env == 'development'
    sh "bundle exec rackup"
  else
    sh "bundle exec puma -e production"
  end
end
