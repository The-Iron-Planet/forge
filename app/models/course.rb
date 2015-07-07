class Course < ActiveRecord::Base
  belongs_to :campus
  belongs_to :curriculum

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
end
