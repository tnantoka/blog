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

class Comment < ActiveRecord::Base
  belongs_to :identity
  belongs_to :post

  validates :body, presence: true

  scope :latest, -> { order(id: :desc) }

  paginates_per 10
end
