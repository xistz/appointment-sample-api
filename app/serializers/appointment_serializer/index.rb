module AppointmentSerializer
  class Index
    include JSONAPI::Serializer
    set_type :appointment

    attributes :from
    attribute :fp do |appointment, params|
      {
        name: params[:users][appointment.fp_id][:name],
        picture: params[:users][appointment.fp_id][:picture]
      }
    end

    attribute :client do |appointment, params|
      {
        name: params[:users][appointment.client_id][:name],
        picture: params[:users][appointment.client_id][:picture]
      }
    end
  end
end
