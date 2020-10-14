module AvailabilitySerializer
  class Index
    include FastJsonapi::ObjectSerializer
    attributes :from
  end
end
