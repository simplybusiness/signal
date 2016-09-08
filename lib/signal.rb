module Signal
  class App
    class << self
      def config
        @config ||= begin
          YAML.load_file('./config/config.yml')
        end
      end

      def call_customer
        client.calls.create(
          :from => App.config['callee_id'],
          :to => App.config['caller_id'],
          :url => connect_url
        )
      end

      private

      def client
        @client ||= Twilio::REST::Client.new(
          App.config['account_sid'],
          App.config['auth_token']
        )
      end

      def connect_url
        'http://58753fbc.ngrok.io/outbound'
      end
    end
  end
end
