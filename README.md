# Signal Simply Business Workshop

A tutorial app that demonstrates who to do end to end test against app that integrates with Twilio.

It will demonstrate to test

- How to receive a call
- How to hangup

## Reference

We will use [Twilio Client Ruby Quickstart](https://www.twilio.com/docs/quickstart/ruby/client) as a base line.

## TODO

1. Write Capybara test
1. Create Sinatra endpoint to call incoming number
1. Dynamically update incoming PhoneNumber [callback url](https://www.twilio.com/docs/api/rest/incoming-phone-numbers) to point to ngrok url
1. Dynamically fetch ngrok url
1. Run the test on Semaphore
