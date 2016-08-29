class Suzy::Queue < Sequel::Model
  one_to_many :messages
end
