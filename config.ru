require_relative 'config/loader.rb'

begin
  run Rack::Cascade.new [Suzy::ApiV1, Suzy::Web]
rescue NameError => e
  if e.message.include? 'uninitialized constant Suzy'
    puts "Failed to load the application server. Perhaps you forgot to run `rake db:create` first?"
    abort
  end
end
