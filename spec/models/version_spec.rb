# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  item_type  :string(255)      not null
#  item_id    :integer          not null
#  event      :string(255)      not null
#  whodunnit  :string(255)
#  object     :text(4294967295)
#  created_at :datetime
#
# Indexes
#
#  index_versions_on_item_type_and_item_id  (item_type,item_id)
#

require 'rails_helper'

RSpec.describe Version, :type => :model do
  with_versioning do
    let!(:post) { create(:post, content: 'first') } 
    let!(:version) do
      post.update!(content: 'second') 
      post.versions.first
    end 

    describe '#diff' do
      subject { version.diff }
      let(:diff) do
        <<-EOD.strip_heredoc
          <div class="diff">
            <ul>
              <li class="ins"><ins><span class="symbol">+</span>first</ins></li>
            </ul>
          </div>
        EOD
      end
      it { should eq(diff) }
    end

    describe '#number' do
      subject { version.number }
      it { should eq('#1') }
    end

    describe '.current' do
      subject { Version.current(post) }
      it { expect(subject.reify.title).to eq(post.title) }
      it { expect(subject.reify.content).to eq(post.content) }
      it { expect(subject.number).to eq('#2') }
    end
  end
end
