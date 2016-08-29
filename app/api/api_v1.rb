require 'grape'

module Suzy
  # The main API to get and receive messages.
  class ApiV1 < Grape::API
    format :json
    version 'v1', using: :path

    resource :queues do
      desc 'Get a queue listing. The response is an object of queue names and corresponding message counts.'
      get do
        Queue.map(&:name).zip(Queue.map {|q| q.messages.size}).to_h
      end

      route_param :queue do
        desc 'Retrieve a message from a queue.'
        get do
          queue = Queue.where(name: params[:queue]).first
          message = queue&.messages&.first
          unless message
            error!({error: "No messages found"}, 204)
          end
          body({
            body: message.body,
            headers: message.headers.map { |h| { h.name => h.value } }.inject({}, :merge)
          })
          message.destroy
        end

        params do
          requires :headers, type: Hash
          requires :body
        end
        desc 'Post a message to a queue.'
        post do
          headers = params[:headers]
          body = params[:body]
          queue_name = params[:queue]

          App.db.transaction do
            queue = Queue.where(name: queue_name).first || Queue.create(name: queue_name)
            message = Message.create(body: body, queue: queue)
            headers.each { |k,v| Header.create(name: k, value: v, message: message) }
          end
          {}
        end
      end
    end
  end
end
