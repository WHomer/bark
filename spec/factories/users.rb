FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :name do |n|
      "User #{n}"
    end

    sequence :email do |n|
      "person#{n}@example.com"
    end
  end
end