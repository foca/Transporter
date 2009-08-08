require "transporter/service/validations"

module Transporter
  class Service
    include Validations

    class << self
      attr_accessor :default_config
    end

    self.default_config = {}

    attr_reader :config

    def initialize(config)
      @config = (self.class.default_config || {}).merge(config)
      raise TypeError, config_errors unless valid_config?(config)
    end

    def deliver(message)
      raise NotImplementedError, "Please implement this method on your service"
    end
  end
end
