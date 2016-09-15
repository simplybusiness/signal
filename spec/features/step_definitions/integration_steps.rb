step 'a consultant is ready to receive a call' do
  visit '/'
  expect(page).to have_twilio_device_status('ready')
  expect(page).to have_content('Ready')
end

step 'a customer calls' do
  # This steps emulates that a user gives a call to a call center for inbound calls.
  # For the outbound calls, you would normally sends a lead task through
  # TaskRouter (https://www.twilio.com/docs/api/taskrouter)
  # This is simplified approach for the demo purpose.
  Signal::App.trigger_call_from_customer
end

step 'the consultant is connected to the customer' do
  expect(page).to have_twilio_device_status('busy')
  # have_conent/have_css will wait for the DOM content change only if the user clicks links or buttons.
  # https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends
  # Because `a customer calls` happens outside of the browser, you either need to
  # sleep or use `have_twilio_device_status('ready')` matcher to wait until the DOM status changes.
  expect(page).to have_content('Successfully established call')
end

step 'the consultant hangs up' do
  # This sleep is just to show the screen. Can be removed
  sleep 10
  click_on('Hangup')
end

step 'the consultant is disconnected from the customer' do
  expect(page).to have_twilio_device_status('ready')
  expect(page).to have_content('Call ended')
end
