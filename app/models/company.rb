class Company < ActiveRecord::Base
  has_many :positions
  has_many :users, through: :positions
  has_many :job_posts

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates_uniqueness_of :name, scope: [:city, :state]

  scope :ordered, -> { order(:name, :state, :city) }

  def name_and_location
    "#{name}: #{city}, #{state}"
  end

  def location
    "#{city}, #{state}"
  end

  def self.has_open_jobs
    job_posts.any? {|j| j.is_active?}
  end

end
