# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text(16777215)   not null
#  published  :boolean          default("0")
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  template   :boolean          default("0")
#  parent_id  :integer
#
# Indexes
#
#  index_posts_on_parent_id  (parent_id)
#  index_posts_on_user_id    (user_id)
#

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
