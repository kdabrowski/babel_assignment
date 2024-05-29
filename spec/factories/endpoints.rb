# frozen_string_literal: true

FactoryBot.define do
  factory :endpoint do
    verb { 'POST' }
    path { '/MyString' }
  end
end
