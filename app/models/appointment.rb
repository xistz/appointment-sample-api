class Appointment < ApplicationRecord
  belongs_to :availability

  validates :client_id, presence: true

  delegate :from, to: :availability
  delegate :fp_id, to: :availability
end
