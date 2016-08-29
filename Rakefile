# Load the Suzy environment
require_relative 'config/loader.rb'

# Load the tasks
Dir[File.join(App.root, 'tasks', '*.rb')].each do |t|
  require t
end
