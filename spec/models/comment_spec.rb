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

require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe 'validation' do
    subject { create(:comment) }
    it { should validate_presence_of(:body) }
  end
end
