class Company < ActiveRecord::Base
  has_many :positions
  has_many :users, through: :positions

  def name_and_location
    "#{name}: #{city}, #{state}"
  end
end
