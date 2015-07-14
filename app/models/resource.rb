class Resource < ActiveRecord::Base
  belongs_to :curriculum
  belongs_to :user

  scope :ordered, -> { order(updated_at: :desc) }

  validates :title, presence: true

end
