# frozen_string_literal: true

RSpec::Matchers.define :authorize_action do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record.inspect} for #{policy.user.inspect}."
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record.inspect} for #{policy.user.inspect}."
  end
end
