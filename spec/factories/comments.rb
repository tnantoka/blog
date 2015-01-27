# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text(65535)
#  identity_id :integer
#  post_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_comments_on_identity_id  (identity_id)
#  index_comments_on_post_id      (post_id)
#

FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph }    
  end
end
