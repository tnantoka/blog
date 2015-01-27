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
# Indexes
#
#  index_attachments_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Attachment, :type => :model do
  describe '#image?' do
    context 'with image' do
      subject { create(:attachment, :image).image? }
      it { should eq(true) }
    end
    #context 'with text' do
    #  subject { create(:attachment, :text).image? }
    #  it { should be_true }
    #end
  end

  describe 'posts' do
    let!(:attachment) { create(:attachment, :image) }
    let!(:post) { create(:post, content: attachment.file.url) }
    subject { attachment.posts }
    it { should eq([post]) }
  end
end
