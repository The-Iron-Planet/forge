class JobPost < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :curriculum

  after_create :user_is_hiring!
  before_destroy :user_is_not_hiring!

  scope :ordered, -> { order(updated_at: :desc) }

  validates :company_id, presence: true
  validates :curriculum_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :experience_desired, presence: true
  validates :expires_on, presence: true
  validate :validate_expire_date_after_current_date

  def validate_expire_date_after_current_date
    if expires_on
      errors.add(:expires_on, "date must be later than today.") if expires_on <= Date.today
    end
  end

  def last_update
    updated_at.strftime "%B %e, %Y"
  end

  def self.search_results(curric_id, city, state, company_id, search_terms, experience_desired)
    result = self.all_active
    result = result.select {|j| j.curriculum_id == curric_id.to_i} if curric_id != ""
    result = result.select {|j| j.company.city.downcase.match(city.downcase)} if city != ""
    result = result.select {|j| j.company.state == state} if state != ""
    result = result.select {|j| j.company_id == company_id.to_i} if company_id != ""
    result = result.select {|j| j.description.downcase.match(search_terms.downcase) || j.title.downcase.match(search_terms.downcase)} if search_terms != ""
    result = result.select {|j| j.experience_desired == experience_desired} if experience_desired != ""
    result
  end

  def self.all_active
    select {|j| j.is_active?}
  end

  def is_active?
    active == true && is_expired? == false
  end

  def is_expired?
    expires_on <= Date.today
  end

  private def user_is_hiring!
    return if self.user.hiring == true
    job_poster = self.user
    job_poster.hiring = true
    job_poster.save!
  end

  private def user_is_not_hiring!
    return if self.user.job_posts.count > 1
    job_poster = self.user
    job_poster.hiring = false
    job_poster.save!
  end
end
