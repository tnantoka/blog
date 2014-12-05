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
