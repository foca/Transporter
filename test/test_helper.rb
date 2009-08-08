require "test/unit"
require "contest"
require File.expand_path(File.dirname(__FILE__) + "/../lib/transporter")

begin
  require "redgreen"
rescue LoadError
end

if ENV["DEBUG"]
  require "ruby-debug"
else
  def debugger
    puts "Run your tests with DEBUG=1 to use the debugger"
  end
end

module Transporter
  def self.test_message_log
    @test_message_log ||= []
  end

  class TestService < Service
    validate_config do |config|
      config.has_keys      :foo, :bar
      config.key_matches   :foo, /^\d+$/
      config.key_is_one_of :baz, ["one", "two", "three"]
    end

    def deliver(message)
      Transporter.test_message_log << {
        :short => message.short,
        :full => message.full
      }
    end
  end
  register :test, TestService

  class TestCase < Test::Unit::TestCase
    setup { Transporter.test_message_log.clear }

    def assert_has_short_message(message)
      if Transporter.test_message_log.detect {|m| message == m[:short] }
        assert true
      else
        flunk
      end
    end

    def assert_has_full_message(message)
      if Transporter.test_message_log.detect {|m| message == m[:full] }
        assert true
      else
        flunk
      end
    end
  end
end
