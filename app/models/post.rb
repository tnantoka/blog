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
  has_many :children, class_name: 'Post', foreign_key: 'parent_id', dependent: :nullify

  validates :title, presence: true
  validates :content, presence: true
  validates_each :parent_id do |record, attr, value|
    record.errors.add(attr, :invalid) if value.present? && value == record.id
  end

  has_many :comments, dependent: :destroy

  scope :latest, -> { order(id: :desc) }
  scope :alphabetical, -> { order(:title) }
  scope :published, -> { where(published: true, template: false) }
  scope :draft, -> { where(published: false, template: false) }
  scope :template, -> { where(template: true) }
  scope :root, -> { where(parent_id: nil) }
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
    Post.published.where('id > ?', self.id).take
  end

  def older
    Post.published.where('id < ?', self.id).latest.take
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
