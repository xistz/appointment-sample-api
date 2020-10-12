class AvailabilitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :from
end
