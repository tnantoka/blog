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

class Comment < ActiveRecord::Base
  belongs_to :identity
  belongs_to :post

  validates :body, presence: true
end
