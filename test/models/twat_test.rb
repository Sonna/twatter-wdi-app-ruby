# frozen_string_literal: true

require "test/test_helper"

module Models
  class TwatTest < Minitest::Test
    def setup
      @imagine = User.create(email: "imagine@email.com", name: "Test imagine",
                             username: "testimagine", password: "password")
    end

    def teardown
      @imagine.destroy
    end

    def test_imagine_twat_contains_written_message
      subject = described_class.create(message: "imagine's pandas dine lovely",
                                       user_id: @imagine.id)
      assert "imagine's pandas dine lovely", subject.message
    ensure
      subject&.destroy
    end

    def test_imagine_twat_count_increase
      assert_equal 0, @imagine.twats_count
      subject = described_class.create(message: "imagine's pandas dine lovely",
                                       user_id: @imagine.id)
      assert_equal 1, @imagine.reload.twats_count
    ensure
      subject&.destroy
    end

    protected

    def described_class
      Twat
    end
  end
end
