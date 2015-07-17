class Resource < ActiveRecord::Base
  include AutoHtml

  belongs_to :curriculum
  belongs_to :user
  has_many :comments, as: :commentable

  after_create :send_resource_email

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

  private def send_resource_email
    User.resource_email_filter(self.curriculum_id).each do |user|
      ResourceMailer.new_resource(user, self).deliver_now
    end
  end

end
