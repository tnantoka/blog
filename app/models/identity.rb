# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  uid        :string(255)      not null
#  provider   :string(255)      not null
#  nickname   :string(255)      not null
#  url        :string(255)      not null
#  raw_info   :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Identity < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  serialize :raw_info

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      self.find_or_initialize_by(uid: auth_hash.uid, provider: auth_hash.provider).tap do |identity|
        identity.assign_attributes(
          nickname: auth_hash.info.nickname,
          url: auth_hash.info.urls.GitHub,
          raw_info: auth_hash.extra.raw_info
        )
        identity.save!
      end
    end
  end
end
