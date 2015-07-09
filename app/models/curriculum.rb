class Curriculum < ActiveRecord::Base
  has_many :courses
  has_many :users, through: :courses
  validates :name, presence: true, uniqueness: true

  def nickname
    curric_hash[name]
  end

  def curric_hash
    { "Rails Engineering" => "Rails",
      "Python Engineering" => "Python",
      "Front End Engineering" => "Front End"
    }
  end
end
