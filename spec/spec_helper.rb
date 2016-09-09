ENV['ENV'] = 'test'

require 'capybara/rspec'
require 'turnip'
require './app.rb'
require 'sinatra'
require './spec/support/twilio_device_rspec_matcher'

Capybara.register_driver :selenium_chrome do |app|
  # This will fake connecting to browser microphone
  # so it does not give 'allow this app to access microphone' popup.
  # Also this option enables us to run the test on the machine which
  # does not have sound card and microphone.
  # More info at https://blog.andyet.com/2014/09/29/testing-webrtc-applications/
  switches = %w(use-fake-ui-for-media-stream use-fake-device-for-media-stream)
  Capybara::Selenium::Driver.new(app, browser: :chrome, switches: switches)
end

Capybara.current_driver = :selenium_chrome
Capybara.app = Sinatra::Application
Capybara.default_max_wait_time = 20
Capybara.server_port = Signal::App.ngrok_tunnelling_port
Dir.glob('spec/features/step_definitions/*steps.rb') { |f| load f, true }
