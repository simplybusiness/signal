# Signal Simply Business Workshop

## Summary

A tutorial app that demonstrates who to do end to end integration test against app that integrates with Twilio. For the full detail, please read [our blog posts](http://tech.simplybusiness.co.uk/2016/06/07/continuous-integration-for-twilio/)

## Target audience

We will assume the following.

- Basic knowledge about how to use [Twilio.js](https://www.twilio.com/docs/api/client/twilio-js)
- Basic knowledge of Ruby and Sinatra web framework
- Basic knowledge of Javascript
- Basic knowledge of testing frameworks and tools, such as [RSpec](http://rspec.info/),[Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin)), and [Capybara](https://github.com/jnicklas/capybara)
- Basic knowledge of CI(Continuous Integration), such as [Semaphoreci](http://semaphoreci.com) though the approach is applicable to other solutions.

## Scope of the tests

We will use [Twilio Client Ruby Quickstart](https://www.twilio.com/docs/quickstart/ruby/client) as a base project.

This sample project demonstrates the followings

1. Write Capybara test that asserts when a consultant receives a call from a customer
1. Dynamically start [ngrok](http://ngrok.com) and fetch its url
1. Dynamically update incoming PhoneNumber [callback url](https://www.twilio.com/docs/api/rest/incoming-phone-numbers) to point to the ngrok url
1. Configure Chrome driver to enable running on the headless environment
1. Run the integration tests on Semaphore
