require 'rails_helper'

RSpec.describe Link, :type => :model do
  describe '#fetch_title' do
    subject { Link.fetch_title('http://tnantoka.com/') }
    it { should eq('tnantoka.com') }
  end
end
