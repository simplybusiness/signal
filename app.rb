# from https://www.twilio.com/docs/quickstart/ruby/client/hello-monkey
require 'sinatra'
require 'twilio-ruby'
require 'yaml'

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

get '/' do
  # Find these values at twilio.com/user/account
  account_sid = App.config['account_sid']
  auth_token = App.config['auth_token']
  demo_app_sid = App.config['demo_app_sid']
  capability = Twilio::Util::Capability.new account_sid, auth_token
  capability.allow_client_outgoing demo_app_sid
  capability.allow_client_incoming "jenny"
  token = capability.generate
  erb :index, :locals => {:token => token}
end

post '/outbound' do
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Hello world', :voice => 'alice'
  end
  response.text
end

post '/inbound' do
  response = Twilio::TwiML::Response.new do |r|
    # Should be your Twilio Number or a verified Caller ID
    r.Dial :callerId => App.config['caller_id'] do |d|
      d.Client 'jenny'
    end
  end
  response.text
end
