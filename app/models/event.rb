class Event < ActiveRecord::Base
  belongs_to :campus
  belongs_to :user

  validates :campus, presence: true

  default_scope {order(happens_on: :asc)}

  has_attached_file :uploaded_file, styles: {
    thumb: '100x100>',
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

end
