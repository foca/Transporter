$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require "ninja"
require "transporter/package"
require "transporter/service"

module Transporter
  def self.deliver(package)
    Package.new(package).deliver
  end

  def self.register(name, service)
    services[name] = service
  end

  def self.load_service(service)
    services.fetch(service)
  end

  def self.services
    @services ||= {}
  end
end
