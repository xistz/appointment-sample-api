# frozen_string_literal: true

module AvailabilityService
  class Create
    def initialize(fp_id:, from:)
      @fp_id = fp_id
      @from = from
    end

    def execute
      is_valid

      availability = Availability.create!(fp_id: @fp_id, from: @from)

      availability.id
    end

    private

    def is_valid
      raise Availability::BadFromError, 'from cannot be a sunday' if @from.sunday?

      first, last = if @from.saturday?
                      [@from.change(hour: 11, min: 0), @from.change(hour: 14, min: 30)]
                    else
                      [@from.change(hour: 10, min: 0), @from.change(hour: 17, min: 30)]
                    end

      unless @from <= last && @from >= first
        message = if @from.saturday?
                    'from has to be between 1100 and 1430 on a saturday'
                  else
                    'from has to be between 1000 and 1730 on a weekday'
                  end

        raise Availability::BadFromError, message
      end

      unless @from.min == 0 || @from.min == 30
        raise Availability::BadFromError, 'from can only begin at the hour or half hour'
      end
    end
  end
end
