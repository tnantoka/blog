# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  uid        :string(255)      not null
#  provider   :string(255)      not null
#  nickname   :string(255)      not null
#  url        :string(255)      not null
#  raw_info   :text(65535)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Identity, :type => :model do
  describe '.find_or_create_from_auth_hash' do
    subject { Identity.find_or_create_from_auth_hash(auth_hash) }
    it { expect(subject.uid).to eq(auth_hash.uid) }
    it { expect(subject.nickname).to eq(auth_hash.info.nickname) }
    it { expect(subject.url).to eq(auth_hash.info.urls.GitHub) }
    it { expect(subject.raw_info).to eq(auth_hash.extra.raw_info) }
  end
end
