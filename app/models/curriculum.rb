class Curriculum < ActiveRecord::Base
  has_many :courses
  has_many :users, through: :courses
  validates :name, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true

  default_scope {order(:name)}
end
