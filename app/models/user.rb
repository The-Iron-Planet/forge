class User < ActiveRecord::Base
  belongs_to :course
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

  after_create :send_account_email

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def current_location
    "#{current_city}, #{current_state}"
  end

  private
    def send_account_email
      UserMailer.account_created(self).deliver_now
    end

end
