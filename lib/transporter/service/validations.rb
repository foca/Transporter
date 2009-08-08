module Transporter
  class Service
    module Validations
      def self.included(service)
        service.extend ClassMethods
      end

      def config_errors
        self.class.validator.errors
      end

      def valid_config?(config)
        self.class.validator.valid?(config)
      end

      module ClassMethods
        def validator(&block)
          @validator ||= Validator.new(&block)
        end
        alias_method :validate_config, :validator
      end

      class Validator
        attr_reader :errors

        def initialize(&block)
          @validations = Hash.new {|h,k| h[k] = [] }
          @errors = Hash.new {|h,k| h[k] = [] }
          block.call(self) if block
        end

        def has_keys(*keys)
          keys.each do |key|
            @validations[key] << lambda do |config|
              config.has_key?(key) or raise TypeError, "config must include '#{key}', but does not"
            end
          end
        end

        def key_matches(key, format)
          @validations[key] << lambda do |config|
            config[key] =~ format or raise TypeError, "config '#{key}' must match '#{format}'"
          end
        end

        def key_is_one_of(key, values)
          @validations[key] << lambda do |config|
            values.include? config[key] or raise TypeError, "config '#{key}' must be one of '#{values.join(", ")}'"
          end
        end

        def valid?(config)
          errors.clear

          @validations.each do |key, validation_list|
            validation_list.each do |validation|
              begin
                validation.call(config)
              rescue TypeError => e
                errors[key] << e.message
              end
            end
          end

          errors.empty?
        end
      end
    end
  end
end
