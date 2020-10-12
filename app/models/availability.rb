class Availability < ApplicationRecord
  validates :user_id, presence: true
  validates :from, presence: true
end
