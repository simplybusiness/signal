require 'twilio-ruby'
require 'yaml'
require './lib/ngrok_runner'

module Signal
  # This class is in charge of the following
  # - load config
  # - start ngrok
  # - update incoming_phone_numbers
  # - call client
  class App
    class << self
      def config
        @config ||= begin
          YAML.load_file(File.expand_path('../../config/config.yml', __FILE__))
        end
      end

      def env
        ENV['ENV'] || 'development'
      end

      def call_customer
        client.calls.create(
          from: "+#{config['callee_id']}",
          to: "+#{config['caller_id']}",
          url: connect_url
        )
      end

      def ngrok_url
        Signal::NgrokRunner.url(env)
      end

      def start
        Signal::NgrokRunner.start_for(env)
        puts "starting nrok on #{ngrok_url}"
        update_incoming_phone_numbers
        puts "updateing to #{incoming_url}"
      end

      def update_incoming_phone_numbers
        number = client.account.incoming_phone_numbers.list(
          friendly_name: config['caller_id']
        ).first
        number.update(voice_url: incoming_url)
      end

      def incoming_url
        "#{ngrok_url}/voice"
      end

      private

      def client
        @client ||= Twilio::REST::Client.new(
          config['account_sid'],
          config['auth_token']
        )
      end

      def connect_url
        "#{ngrok_url}/customer_voice"
      end
    end
  end
end
