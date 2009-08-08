module Transporter
  class Package
    include Ninja

    attr_reader :short, :full

    def initialize(package)
      message = package.fetch(:message)
      @short = message.fetch(:short)
      @full = message.fetch(:full)
      @services = package.fetch(:using)
    end

    def deliver
      delivery_services.each do |service|
        in_background { service.deliver(self) }
      end
    end

    private

    def delivery_services
      @services.map do |service, config|
        Transporter.load_service(service).new(config)
      end
    end
  end
end
