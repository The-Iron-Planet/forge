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

  validates_format_of :website, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
      message: "Invalid website format.  Must be http(s)://website_urle"

  scope :ordered, -> { order(:last_name, :first_name) }

  accepts_nested_attributes_for :positions, reject_if: proc { |attributes| attributes['company_id'].blank? && attributes['title'].blank? }

  after_create :send_account_email

  auto_html_for :website do
    html_escape
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def current_location
    "#{current_city}, #{current_state}"
  end

  def twitter_link
    "https://www.twitter.com/#{twitter}"
  end

  def github_link
    "https://github.com/#{github_profile}"
  end

  def current_position
    positions.ordered.first
  end

  def tiy_relation
    if is_cd
      "Staff"
    elsif is_instructor
      "#{curriculum.nickname} Instructor"
    else
      "#{curriculum.nickname} - #{course.start_date}"
    end
  end

  def self.event_email_filter(campus_id)
    select {|u| u.get_event_email == true && u.campus_notification_id == campus_id}
  end

  def self.job_email_filter(curric_id)
    select {|u| u.get_job_email == true && u.curriculum_id == curric_id}
  end

  def self.resource_email_filter(curric_id)
    select {|u| u.get_resource_email == true && u.curriculum_id == curric_id}
  end

  def self.search_results(query, campus_id, curric_id, job_status)
    queries = query.split(/\W+/)
    relation = self
    queries.each do |q|
      relation = relation.where("first_name LIKE '%#{q}%' OR last_name LIKE '%#{q}%' OR current_city LIKE '%#{q}%' OR current_state LIKE '%#{q}%'")
    end
    relation = relation.where(campus_id: campus_id) if campus_id != ""
    relation = relation.where(curriculum_id: curric_id) if curric_id != ""
    relation = relation.where(looking: true) if job_status == "Looking for work"
    relation = relation.where(hiring: true) if job_status == "Hiring"
    relation
  end

  # def self.search_results(name, city, state, curric_id, campus_id, job_status, company_id, cohort_class, current_user)
  #   result = self
  #   if company_id != ""
  #     company = Company.find_by_id(company_id)
  #     result = company.users
  #   end
  #   if cohort_class == "My Cohort"
  #     courses = Course.select {|c| c.campus_id == current_user.course.campus.id && c.started_on == current_user.course.started_on}
  #     result = result.where(course: courses)
  #   end
  #   if campus_id != ""
  #     courses = Course.select {|c| c.campus_id == campus_id.to_i}
  #     result = result.where(course: courses)
  #   end
  #   if curric_id != ""
  #     courses = Course.select {|c| c.curriculum_id == curric_id.to_i}
  #     result = result.where(course: courses)
  #   end
  #   if cohort_class == "My Classmates"
  #     result = result.select {|u| u.course_id == current_user.course_id}
  #   end
  #   result = result.select {|u| u.current_state.downcase == state.downcase } if state != ""
  #   result = result.select {|u| u.current_city.downcase.match(city.downcase) } if city != ""
  #   result = result.select {|u| u.looking} if job_status == "Looking for work"
  #   result = result.select {|u| u.hiring} if job_status == "Hiring"
  #   result = result.select {|u| u.full_name.downcase.match(name.downcase)} if name != ""
  #   result
  # end

  private
    def send_account_email
      # UserMailer.account_created(self).deliver_now
    end
end
