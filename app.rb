# from https://www.twilio.com/docs/quickstart/ruby/client/hello-monkey
require 'sinatra'
require 'twilio-ruby'
require 'yaml'
require './lib/signal'
require './lib/ngrok_runner'

get '/' do
  # Find these values at twilio.com/user/account
  account_sid = Signal::App.config['account_sid']
  auth_token = Signal::App.config['auth_token']
  capability = Twilio::Util::Capability.new account_sid, auth_token
  # This application sid will play a Welcome Message.
  demo_app_sid = 'APabe7650f654fc34655fc81ae71caa3ff'
  capability.allow_client_outgoing demo_app_sid
  capability.allow_client_incoming 'jenny'
  token = capability.generate
  erb :index, locals: { token: token }
end

post '/voice' do
  response = Twilio::TwiML::Response.new do |r|
    # Should be your Twilio Number or a verified Caller ID
    r.Dial callerId: "+#{Signal::App.config['caller_id']}" do |d|
      d.Client 'jenny'
    end
  end
  response.text
end

post '/customer_voice' do
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Hello World. Signal conference London. Lukas is a fine young lad. Buy him a pint after this workshop', voice: 'alice'
  end
  response.text
end

if %w(development test).include? Signal::App.env
  Thread.new { Signal::App.start }
end
