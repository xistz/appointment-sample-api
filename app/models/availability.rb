class Availability < ApplicationRecord
  has_one :appointment

  validates :user_id, presence: true
  validates :from, presence: true
end
