module AvailabilitySerializer
  class Index
    include JSONAPI::Serializer
    set_type :availability

    attributes :from
  end
end
