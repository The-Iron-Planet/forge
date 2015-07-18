class JobPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :curriculum

  after_create :user_is_hiring!
  after_create :send_job_email
  before_destroy :user_is_not_hiring!

  scope :ordered, -> { order(updated_at: :desc) }

  validates :company_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :curriculum_id, presence: true
  validates :title, presence: true
  # validates :description, presence: true
  validates :experience_desired, presence: true
  # validates :expires_on, presence: true
  # validate :validate_expire_date_after_current_date

  validates_format_of :website, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
      message: "Invalid website format.  Must be http(s)://website_url",
      allow_blank: true

  auto_html_for :website do
    html_escape
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  # def validate_expire_date_after_current_date
  #   if expires_on
  #     errors.add(:expires_on, "date must be later than today.") if expires_on <= Date.today
  #   end
  # end

  def last_update
    updated_at.strftime "%B %e, %Y"
  end

  def self.search_results(query, experience, curric_id)
    relation = self
    if query != ""
      queries = query.split(/\W+/)
      queries.each do |q|
        relation = relation.where("city LIKE '%#{q}%' OR state LIKE '%#{q}%' OR title LIKE '%#{q}%' OR company_name LIKE '%#{q}%' OR description LIKE '%#{q}%'")
      end
    end
    relation = relation.where(experience_desired: experience) if experience != ""
    relation = relation.where(curriculum_id: curric_id) if curric_id != ""
    relation
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

  private def send_job_email
    # User.job_email_filter(self.curriculum_id).each do |user|
    #   UserMailer.new_job(user, self).deliver_now
    # end
  end
end
