RSpec::Matchers.define :have_twilio_device_status do |expected_status|
  match do |page|
    attempts = 0
    while attempts < Capybara.default_max_wait_time
      return true if page.evaluate_script('Twilio.Device.status()') == expected_status
      attempts += 1
      sleep 1
    end
    false
  end

  failure_message do
    "expected the Twilio device to be '#{expected_status}'"
  end

  failure_message_when_negated do
    "expected the Twilio device to not be '#{expected_status}'"
  end

  description do
    "Twilio device is '#{expected_status}'"
  end
end
