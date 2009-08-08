require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class TestTransporter < Transporter::TestCase
  def valid_message
    {
      :message => {
        :short => "short message",
        :full => "full message"
      },
      :using => {
        :test => {
          :foo => "1234",
          :bar => "cuack",
          :baz => "two"
        }
      }
    }
  end

  test "delivers messages to the specified recipients" do
    Transporter.deliver(valid_message)

    assert_has_short_message "short message"
    assert_has_full_message "full message"
  end

  test "raises TypeError when passing an invalid config for the Service" do
    message = valid_message
    message[:using][:test][:foo] = nil

    assert_raises TypeError do
      Transporter.deliver(message)
    end
  end
end
