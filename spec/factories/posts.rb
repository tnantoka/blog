FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }    
    content { Faker::Lorem.paragraph }    
    trait :published do
      published true
    end
    trait :draft do
      published false
    end
    trait :template do
      template true
    end
  end
end
