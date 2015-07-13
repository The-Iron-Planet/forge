class Event < ActiveRecord::Base
  belongs_to :campus
  belongs_to :user

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

  def event_date
    happens_on.strftime "%a, %b %e, %Y"
  end

  def event_time
    happens_on.strftime "%l:%M %p"
  end

  def self.search_results(campus_id)
    where(campus_id: campus_id.to_i) if campus_id != ""
  end

end
