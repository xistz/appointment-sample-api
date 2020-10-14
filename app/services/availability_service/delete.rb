# frozen_string_literal: true

module AvailabilityService
  class Delete
    def initialize(fp_id:, availability_id:)
      @fp_id = fp_id
      @availability_id = availability_id
    end

    def execute
      availability = Availability.find_by!(id: @availability_id, fp_id: @fp_id)

      availability.destroy
    end
  end
end
