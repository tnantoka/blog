# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  item_type  :string(255)      not null
#  item_id    :integer          not null
#  event      :string(255)      not null
#  whodunnit  :string(255)
#  object     :text(2147483647)
#  created_at :datetime
#

class Version < PaperTrail::Version
  include Cacheable

  scope :latest, -> { reorder(id: :desc) }

  paginates_per 10

  class << self
    def current(post)
      self.new(
        id: post.versions.count + 1,
        item_id: post.id,
        item_type: 'Post',
        event: 'update',
        object: ActiveSupport::JSON.encode(post),
        whodunnit: post.user_id.to_s
      )
    end
  end

  def diff
    cached(:_diff)
  end

  def index
    persisted? ? super : item.versions.count
  end

  def number
    "##{index.to_i + 1}"
  end

  private
    def _diff
      before = reify.previous_version.try(:content).to_s
      after = reify.content.to_s
      diff = Diffy::Diff.new(before, after, include_plus_and_minus_in_html: true)
      diff.to_s.present? ? diff.to_s(:html) : nil
    end
end
