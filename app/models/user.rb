class User < ActiveRecord::Base
  belongs_to :course
  has_many :positions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
      :validatable

  has_attached_file :uploaded_file, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :uploaded_file, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  default_scope {order(:last_name, :first_name)}

  accepts_nested_attributes_for :positions, reject_if: proc { |attributes| attributes['company_id'].blank? || attributes['title'].blank? }

  after_create :send_account_email

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def current_location
    "#{current_city}, #{current_state}"
  end

  def current_position
    positions.first
  end

  def self.search_by_city(city)
    self.select {|u| u.current_city.downcase == city.downcase }
  end

  def self.search_by_state(state)
    self.select {|u| u.current_state.downcase == state.downcase }
  end

  def self.looking?
    self.select {|u| u.looking}
  end

  def self.search_results(city, state, looking)
    result = self
    result = result.search_by_state(state) if state != ""
    result = result.select {|u| u.current_city.downcase == city.downcase } if city != ""
    result = result.select {|u| u.looking} unless looking.nil?
    result
  end
  #
  # def self.search_by_curriculum(curric_id)
  #   self.where(course_id: (Course.where(curriculum_id: curric_id).id))
  # end

  private
    def send_account_email
      # UserMailer.account_created(self).deliver_now
    end

    # def search_params
    #   params.permit(:current_state, :current_city)
    # end

end
