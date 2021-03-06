class Resource < ActiveRecord::Base
  include AutoHtml

  belongs_to :curriculum
  belongs_to :user
  has_many :comments, as: :commentable

  after_create :send_resource_email

  scope :ordered, -> { order(updated_at: :desc) }

  validates :title, presence: true
  validates :curriculum_id, presence: true

  validates_format_of :website, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
      message: "Invalid website format.  Must be http(s)://website_url",
      allow_blank: true

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
    queries = query.downcase.split(/\W+/)
    queries.each do |q|
      relation = relation.where("lower(title) LIKE '%#{q}%' OR lower(description) LIKE '%#{q}%'")
    end
    relation
  end

  private def send_resource_email
    # User.resource_email_filter(self.curriculum_id).each do |user|
    #   UserMailer.new_resource(user, self).deliver_now
    # end
  end

end
