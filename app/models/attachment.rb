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

class Attachment < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file
  do_not_validate_attachment_file_type :file

  scope :latest, -> { order(id: :desc) }

  paginates_per 10

  def image?
    !!(file_content_type =~ /image/) 
  end

  def posts
    Post.where('content LIKE ?', "%#{file.url}%").latest
  end
end
