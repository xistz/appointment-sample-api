module AvailabilitySerializer
  class SearchByDate
    include JSONAPI::Serializer
    set_type :availability

    attributes :from
  end
end
