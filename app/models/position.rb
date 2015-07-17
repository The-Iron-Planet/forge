class Position < ActiveRecord::Base
  belongs_to :user

  validates :company_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :title, presence: true
  validates :started_on, presence: true

  scope :ordered, -> { order(started_on: :desc) }

  # def company_name
  #   company.name_and_location
  # end

  def start_date
    started_on.strftime "%B %Y"
  end

  def end_date
    ended_on.strftime "%B %Y"
  end
end
