module Suzy
  class Web < Sinatra::Base
    helpers do
      def path_display(path)
        path.gsub(/(:\w+)/, "<strong>\\1</strong>")
        # path
      end
    end

    get '/console' do
      @queues = Queue.all
      slim :index
    end

    get '/console/routes' do
      @routes = Suzy::ApiV1.routes
      slim :routes, layout: :layout
    end

    get '/console/delete/:queue' do
      queue = Queue.where(name: params[:queue]).first
      queue.destroy
      redirect to('/console')
    end

    get '/console/purge/:queue' do
      queue = Queue.where(name: params[:queue]).first
      Message.where(queue: queue).destroy
      redirect to('/console')
    end
  end
end
