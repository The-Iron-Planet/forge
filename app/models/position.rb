class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  default_scope {order(started_on: :desc)}

  def company_name
    company.name_and_location
  end
end
