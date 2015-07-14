class Resource < ActiveRecord::Base
  belongs_to :curriculum
  belongs_to :user

  scope :ordered, -> { order(title: :asc) }

  validates :title, presence: true

end
