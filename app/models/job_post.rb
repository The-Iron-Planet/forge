class JobPost < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :curriculum

  scope :ordered, -> { order(updated_at: :desc) }

  validates :company_id, presence: true
  validates :curriculum_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :experience_desired, presence: true

  def last_update
    updated_at.strftime "%B %e, %Y"
  end

  def self.search_results(curric_id, city, state)
    result = self
    result = result.where(curriculum_id: curric_id) if curric_id != ""
    result = result.select {|j| j.company.city.downcase.match(city.downcase)} if city != ""
    result = result.select {|j| j.company.state == state} if state != ""
    result
  end
end
