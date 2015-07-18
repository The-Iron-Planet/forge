class Event < ActiveRecord::Base
  belongs_to :campus
  belongs_to :user
  has_many :comments, as: :commentable

  validates :campus, presence: true

  scope :ordered, -> { order(happens_on: :asc) }
  # default_scope {order(happens_on: :asc)}

  has_attached_file :uploaded_file, styles: {
    thumb: '50x50>',
    small: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :uploaded_file, :content_type => /\Aimage\/.*\Z/

  after_create :send_event_email

  def event_date
    happens_on.strftime "%a, %b %e, %Y"
  end

  def event_time
    happens_on.strftime "%l:%M %p"
  end

  def self.search_results(query, campus_id)
    relation = self
    if query != ""
      queries = query.split(/\W+/)
      queries.each do |q|
        relation = relation.where("name LIKE '%#{q}%' OR description LIKE '%#{q}%'")
      end
    end
    relation = relation.where(campus_id: campus_id.to_i) if campus_id != ""
    relation
  end

  private def send_event_email
    # User.event_email_filter(self.campus_id).each do |user|
    #   UserMailer.new_event(user, self).deliver_now
    # end
  end

end
