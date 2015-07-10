class Event < ActiveRecord::Base
  belongs_to :campus
  belongs_to :user

  
end
