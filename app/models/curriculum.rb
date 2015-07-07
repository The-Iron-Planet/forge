class Curriculum < ActiveRecord::Base
  has_many :courses

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
