class Course < ActiveRecord::Base
  belongs_to :campus
  belongs_to :curriculum

  validates :started_on, presence: true
  validates :ended_on, presence: true
  validates :campus_id, presence: true
  validates :curriculum_id, presence: true
  validates_uniqueness_of :cohort, scope: [:campus_id, :curriculum_id]
  validates_numericality_of :cohort, greater_than: 0
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date
    if started_on && ended_on
      errors.add(:ended_on, "date must be later than Started on date.") if ended_on < started_on
    end
  end

  def campus_short
    campus.short_name
  end

  def campus_long
    campus.long_name
  end

  def curric_name
    curriculum.name
  end

  def start_date
    started_on.strftime "%B %Y"
  end

  def end_date
    ended_on.strftime "%B %Y"
  end

  def full_description
    "#{campus.short_name}: #{curriculum.nickname} Cohort #{cohort}"
  end
end