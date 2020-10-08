# frozen_string_literal: true

# ApplicationService defines base class for other services to inherit
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
