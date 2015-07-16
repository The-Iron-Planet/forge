class User < ActiveRecord::Base
  belongs_to :course
  belongs_to :campus
  belongs_to :curriculum
  has_many :positions
  has_many :events
  has_many :job_posts
  has_many :resources
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
      :validatable

  has_attached_file :uploaded_file, styles: {
    thumb: '50x50>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :uploaded_file, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :campus_id, presence: true
  validates_presence_of :curriculum_id, :unless => Proc.new { |u| u.is_cd == true }
  validates_presence_of :course_id, :if => Proc.new { |u| u.is_cd != true && u.is_instructor != true }
  # validates :curriculum, presence: true proc { unless cd }
  # validates :course_id, presence: true proc { if student }

  scope :ordered, -> { order(:last_name, :first_name) }

  accepts_nested_attributes_for :positions, reject_if: proc { |attributes| attributes['company_id'].blank? && attributes['title'].blank? }

  after_create :send_account_email

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def current_location
    "#{current_city}, #{current_state}"
  end

  def current_position
    positions.ordered.first
  end

  def tiy_relation
    if is_cd
      "#{campus.short_name}: Staff"
    elsif is_instructor
      "#{campus.short_name}: #{curriculum.nickname} - Instructor"
    else
      course.full_description
    end
  end

  def self.search_results(name, city, state, curric_id, campus_id, job_status, company_id, cohort_class, current_user)
    result = self
    if company_id != ""
      company = Company.find_by_id(company_id)
      result = company.users
    end
    if cohort_class == "My Cohort"
      courses = Course.select {|c| c.campus_id == current_user.course.campus.id && c.started_on == current_user.course.started_on}
      result = result.where(course: courses)
    end
    if campus_id != ""
      courses = Course.select {|c| c.campus_id == campus_id.to_i}
      result = result.where(course: courses)
    end
    if curric_id != ""
      courses = Course.select {|c| c.curriculum_id == curric_id.to_i}
      result = result.where(course: courses)
    end
    if cohort_class == "My Classmates"
      result = result.select {|u| u.course_id == current_user.course_id}
    end
    result = result.select {|u| u.current_state.downcase == state.downcase } if state != ""
    result = result.select {|u| u.current_city.downcase.match(city.downcase) } if city != ""
    result = result.select {|u| u.looking} if job_status == "Looking for work"
    result = result.select {|u| u.hiring} if job_status == "Hiring"
    result = result.select {|u| u.full_name.downcase.match(name.downcase)} if name != ""
    result
  end

  private
    def send_account_email
      # UserMailer.account_created(self).deliver_now
    end

end
