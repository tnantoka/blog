# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text(16777215)   not null
#  published  :boolean
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:markdown) { '# Header' }

  describe 'validation' do
    subject { create(:post) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe '#render' do
    subject { create(:post, content: markdown).render }
    it { should eq("<h1 id=\"header\">Header</h1>\n") }
  end

  describe '#toc' do
    let(:toc) do
      <<-EOD.strip_heredoc
        <ul>
        <li>
        <a href="#header">Header</a>
        </li>
        </ul>
      EOD
    end
    subject { create(:post, content: markdown).toc }
    it { should eq(toc) }
  end

  describe '#content_text' do
    subject { create(:post, content: markdown).content_text }
    it { should eq("Header\n") }
  end

  describe '#count' do
    subject { create(:post, content: markdown).count }
    it { should eq(6) }
  end

  describe '.search' do
    before { create_list(:post, 10) }
    let(:query) { 'a' }
    subject { Post.search(query) }
    it { should eq(Post.all.select { |p| p.title =~ /#{query}/ || p.content =~ /#{query}/ }) }
  end
end
