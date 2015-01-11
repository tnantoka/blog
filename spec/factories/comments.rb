# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text
#  identity_id :integer
#  post_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph }    
  end
end
