class Availability < ApplicationRecord
  has_one :appointment, dependent: :destroy

  validates :fp_id, presence: true
  validates :from, presence: true
end
