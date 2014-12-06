require 'rails_helper'

RSpec.describe Link, :type => :model do
  describe '#fetch_title' do
    context 'success' do
      subject { Link.fetch_title('http://example.com/') }
      it { should eq('Example') }
    end
    context 'not found' do
      subject { Link.fetch_title('http://example.com/404') }
      it { should eq('') }
    end
    context 'invalid' do
      subject { Link.fetch_title('invalid') }
      it { should eq('') }
    end
  end
end
