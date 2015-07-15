class Resource < ActiveRecord::Base
  include AutoHtml

  belongs_to :curriculum
  belongs_to :user

  scope :ordered, -> { order(updated_at: :desc) }

  validates :title, presence: true
  validates :curriculum_id, presence: true

  auto_html_for :website do
    html_escape
    # image
    # gist
    metacafe
    # google_map
    # ted
    twitter
    vimeo
    youtube(:width => 400, :height => 250, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def self.search_results(curriculum_id)
    where(curriculum_id: curriculum_id.to_i) if curriculum_id != ""
  end

end
