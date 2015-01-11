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

require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe 'validation' do
    subject { create(:comment) }
    it { should validate_presence_of(:body) }
  end
end
