require 'capybara/rspec'
require 'turnip'
require './app.rb'
require 'sinatra'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.current_driver = :selenium_chrome
Capybara.app = Sinatra::Application
Dir.glob('spec/features/step_definitions/*steps.rb') { |f| load f, true }
