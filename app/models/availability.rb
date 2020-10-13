class Availability < ApplicationRecord
  has_one :appointment, dependent: :destroy

  validates :user_id, presence: true
  validates :from, presence: true
end
