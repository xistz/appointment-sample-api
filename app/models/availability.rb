class Availability < ApplicationRecord
  validates :user_id, presence: true
  validates :from, presence: true

  validate :from_is_valid

  def from_is_valid
    if from.sunday?
      errors.add(:from, 'cannot be a sunday')
      return
    end

    # saturday
    if from.saturday?
      first = from.change(hour: 11, min: 0)
      last = from.change(hour: 14, min: 30)

      errors.add(:from, 'has to be between 1100 and 1430 on saturday') unless from <= last && from >= first

    # weekday
    else
      first = from.change(hour: 10, min: 0)
      last = from.change(hour: 17, min: 30)

      errors.add(:from, 'has to be between 1100 and 1430 on saturday') unless from <= last && from >= first
    end

    errors.add(:from, 'can only begin at the hour or half hour') unless from.min == 0 || from.min == 30
  end
end
