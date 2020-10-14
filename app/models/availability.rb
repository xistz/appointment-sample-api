class Availability < ApplicationRecord
  has_one :appointment, dependent: :destroy

  validates :fp_id, presence: true
  validates :from, presence: true

  scope :free, -> { left_outer_joins(:appointment).where(appointments: { availability_id: nil }) }
end
