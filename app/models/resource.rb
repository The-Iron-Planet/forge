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

  def self.search_results(query)
    relation = self
    queries = query.split(/\W+/)
    queries.each do |q|
      relation = relation.where("title LIKE '%#{q}%' OR description LIKE '%#{q}%'")
    end
    relation
  end

  private def send_resource_email
    # User.resource_email_filter(self.curriculum_id).each do |user|
    #   UserMailer.new_resource(user, self).deliver_now
    # end
  end

end
