class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :current_city, presence: true
  # validates :current_state, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def current_location
    "#{current_city}, #{current_state}"
  end
end
