# frozen_string_literal: true

FactoryBot.define do
  factory :registration, class: 'Registration' do
    child factory: :internal_child
    invoice

    factory :slot_reg do
      registerable factory: :time_slot
    end

    factory :slot_opt_reg do
      registerable factory: :slot_option
    end

    factory :event_opt_reg do
      registerable factory: :event_option
    end
  end
end
