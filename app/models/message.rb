class Suzy::Message < Sequel::Model
  many_to_one :queue
  one_to_many :headers

  def after_create
    queue.update(enqueued: queue.enqueued + 1)
    super
  end

  def after_destroy
    queue.update(dequeued: queue.dequeued + 1)
    super
  end
end
