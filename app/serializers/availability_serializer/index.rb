module AvailabilitySerializer
  class Index
    include JSONAPI::Serializer
    attributes :from
  end
end
