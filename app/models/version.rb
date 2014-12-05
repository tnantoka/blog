class Version < PaperTrail::Version
  include Cacheable

  scope :latest, -> { reorder(id: :desc) }

  paginates_per 10

  def diff
    cached(:_diff)
  end

  def number
    "##{index + 1}"
  end

  private
    def _diff
      before = reify.previous_version.try(:content).to_s
      after = reify.content.to_s
      diff = Diffy::Diff.new(before, after, include_plus_and_minus_in_html: true)
      diff.to_s.present? ? diff.to_s(:html) : nil
    end
end
