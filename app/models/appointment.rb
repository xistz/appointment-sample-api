class Appointment < ApplicationRecord
  belongs_to :availability

  validates :client_id, presence: true
end
