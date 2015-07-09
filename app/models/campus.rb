class Campus < ActiveRecord::Base
  has_many :courses
  has_many :users, through: :courses

  validates :city, presence: true
  validates_uniqueness_of :city, scope: :state
  validates :state, presence: true

  def long_name
    "#{city}, #{state}"
  end

  def short_name
    city
  end
end
