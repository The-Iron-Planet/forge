class Campus < ActiveRecord::Base
  has_many :courses

  def long_name
    "#{city}, #{state}"
  end

  def short_name
    city
  end
end
