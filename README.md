# Signal Simply Business Workshop

## Summary

A tutorial app that demonstrates how to write and setup end to end integration tests against an application that integrates with Twilio. For the full detail, please read [our](http://tech.simplybusiness.co.uk/2016/06/07/continuous-integration-for-twilio/) [blog](http://tech.simplybusiness.co.uk/2016/06/07/continuous-integration-for-twilio-part-2/) [posts](http://tech.simplybusiness.co.uk/2016/06/07/continuous-integration-for-twilio-part-3/).

## Target audience

We assume you are already familiar with the following.

- Basic knowledge about how to use [Twilio.js](https://www.twilio.com/docs/api/client/twilio-js)
- Basic knowledge of Ruby and Sinatra web framework
- Basic knowledge of Javascript
- Basic knowledge of testing frameworks and tools, such as [RSpec](http://rspec.info/),[Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin), and [Capybara](https://github.com/jnicklas/capybara)
- Basic knowledge of CI(Continuous Integration), such as [Semaphoreci](http://semaphoreci.com) though the approach is applicable to other solutions.

This project is tested under OS X only.

## Scope of the tests

We use [Twilio Client Ruby Quickstart](https://www.twilio.com/docs/quickstart/ruby/client) as a base project.

This sample project demonstrates the followings

1. Write Capybara test that asserts when a consultant receives a call from a customer
1. Dynamically start [ngrok](http://ngrok.com) and fetch its url
1. Dynamically update incoming PhoneNumber [callback url](https://www.twilio.com/docs/api/rest/incoming-phone-numbers) to point to the ngrok url
1. Configure Chrome driver to enable running on the headless environment
1. Run the integration tests on Semaphore

## How to setup

### Clone the repo

```
git clone https://github.com/simplybusiness/signal
cd signal
bundle
```

### Create config file

```
cp config/config.yml.example config/config.yml
```

### Obtain Twilio Account SID and Auth Token

Follow [this Twilio guide](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-how-to-change-them) to botain Account SID and Auth token, then add them to `config/conig.yml` as `account_sid` and `auth_token`

### Purchase Twilio Incoming number

Purchase [Twilio incoming number](https://www.twilio.com/user/account/phone-numbers/incoming
), then add the number to `config/conig.yml` as `caller_id` (please omit `+`)

## Running the test locally

```
bundle exec rake
```

## Running the test on CI

At the `Seeings` section of your project, please do the followings

### Add command lines

![semaphore_build_settings](doc/img/semaphore_build_settings.png)

### Upload `config/config.yml`

Make sure you tick 'Encrypt file'

![semaphore_configuration_files](doc/img/semaphore_configuration_files.png)
