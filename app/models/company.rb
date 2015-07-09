class Company < ActiveRecord::Base
  has_many :positions
  has_many :users, through: :positions

  default_scope {order(:name, :state, :city)}

  def name_and_location
    "#{name}: #{city}, #{state}"
  end

  def location
    "#{city}, #{state}"
  end

end
