# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

include ActionDispatch::TestProcess 

FactoryGirl.define do
  factory :attachment do
    trait :image do
      file { fixture_file_upload(Rails.root.join('spec/fixtures/image.png'), 'image/png') }
    end
    trait :text do
      file { fixture_file_upload(Rails.root.join('spec/fixtures/text.txt'), 'text/plain') }
    end
  end
end
