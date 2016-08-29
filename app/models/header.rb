class Suzy::Header < Sequel::Model
  many_to_one :message
end
