module Signal
  class App
    def self.config
      @config ||= begin
        YAML.load_file('./config/config.yml')
      end
    end

    def self.call_customer
      client = Twilio::REST::Client.new(
        App.config['account_sid'],
        App.config['auth_token']
      )
      call = client.calls.create(
        :from => App.config['callee_id'],
        :to => App.config['caller_id'],
        :url => connect_url
      )
    end

    def self.connect_url
      'http://58753fbc.ngrok.io/outbound'
    end
  end
end
