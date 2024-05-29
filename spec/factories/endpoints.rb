FactoryBot.define do
  factory :endpoint do
    verb { 'POST' }
    path { '/MyString' }
  end
end
