# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text(16777215)   not null
#  published  :boolean          default("0")
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  template   :boolean          default("0")
#  parent_id  :integer
#
# Indexes
#
#  index_posts_on_parent_id  (parent_id)
#  index_posts_on_user_id    (user_id)
#

class Post < ActiveRecord::Base
  include Cacheable

  belongs_to :user
  belongs_to :parent, class_name: 'Post'

  validates :title, presence: true
  validates :content, presence: true

  has_many :comments, dependent: :destroy

  scope :latest, -> { order(updated_at: :desc) }
  scope :published, -> { where(published: true, template: false) }
  scope :draft, -> { where(published: false, template: false) }
  scope :template, -> { where(template: true) }
  scope :search, -> query { 
    q = "%#{query}%"  
    where('title LIKE ? OR content LIKE ?', q, q) 
  }

  paginates_per 10

  has_paper_trail class_name: 'Version', on: [:update]

  def render
    cached(:_render)
  end

  def toc
    cached(:_toc)
  end

  def content_text
    cached(:_content_text)
  end

  def count
    content_text.gsub(/\n|\r/, '').size
  end

  def newer
    Post.published.where('updated_at > ?', updated_at).latest.last
  end

  def older
    Post.published.where('updated_at < ?', updated_at).latest.first
  end

  private
    def _render 
      MarkdownRenderer.render(content)
    end

    def _toc
      MarkdownRenderer.toc(content)
    end

    def _content_text
      doc.text
    end

    def doc
      doc = Nokogiri::HTML.fragment(render)
    end
end
