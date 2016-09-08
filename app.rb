# from https://www.twilio.com/docs/quickstart/ruby/client/hello-monkey
require 'sinatra'
require 'twilio-ruby'
require 'yaml'
require './lib/signal'

get '/' do
  # Find these values at twilio.com/user/account
  account_sid = Signal::App.config['account_sid']
  auth_token = Signal::App.config['auth_token']
  demo_app_sid = Signal::App.config['demo_app_sid']
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
    r.Dial :callerId => Signal::App.config['caller_id'] do |d|
      d.Client 'jenny'
    end
  end
  response.text
end
