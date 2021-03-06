module ProxyAPI
  module ForemanDynflow
    class DynflowProxy
      PREFIX = 'dynflow'

      class Task < ProxyAPI::Resource
        def initialize(args)
          @url = "#{args[:url]}/#{PREFIX}/tasks"
          super args
          @connect_params[:headers] ||= {}
          @connect_params[:headers]['content-type'] = 'application/json'
        end
      end

      def initialize(args)
        @args = args
      end

      # Initiate the command
      def trigger_task(action_name, action_input)
        payload = MultiJson.dump(:action_name => action_name, :action_input => action_input)
        MultiJson.load(Task.new(@args).send(:post, payload))
      end

      # Initiate the command
      def cancel_task(proxy_task_id)
        MultiJson.load(Task.new(@args).send(:post, "", "#{ proxy_task_id }/cancel"))
      end
    end
  end
end
