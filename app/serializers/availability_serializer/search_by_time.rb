module AvailabilitySerializer
  class SearchByTime
    include JSONAPI::Serializer
    set_type :availability

    attribute :fp_name do |availability, params|
      puts params[:users]
      params[:users][availability.fp_id][:name]
    end

    attribute :fp_picture do |availability, params|
      params[:users][availability.fp_id][:picture]
    end
  end
end
