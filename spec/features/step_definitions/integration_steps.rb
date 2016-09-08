step 'a consultant is ready to receive a call' do
  visit '/'
  expect(page).to have_twilio_device_status('ready')
  expect(page).to have_content('Ready')
end

step 'a customer calls' do
  Signal::App.call_customer
end

step 'the consultant is connected to the customer' do
  expect(page).to have_twilio_device_status('busy')
  expect(page).to have_content('Successfully established call')
end

step 'the consultant hangs up' do
  # This sleep is just to show the screen. Can be removed
  sleep 5
  click_on('Hangup')
end

step 'the consultant is diconneted from the cusotmer' do
  expect(page).to have_twilio_device_status('ready')
  expect(page).to have_content('Call ended')
end
