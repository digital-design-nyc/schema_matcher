require 'ffaker'
require_relative './models/user'
require_relative './models/post'

FactoryBot.define do
  factory :user do
    skip_create
    id { rand(100) }
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    mobile { FFaker::PhoneNumber.short_phone_number }
    post_ids { [1, 2, 3] }
  end

  factory :post do
    skip_create
    id { rand(100) }
    content { FFaker::Lorem.sentence }
    author { attributes_for(:user).stringify_keys }
  end
end
