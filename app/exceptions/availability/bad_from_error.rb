class Availability::BadFromError < StandardError
  def initialize(message)
    super(message)
  end
end
