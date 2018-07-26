# frozen_string_literal: true

require "test/test_helper"

module Models
  class NullUserTest < Minitest::Test
    def setup
      @subject = NullUser.new
    end

    def teardown
      @subject = nil
    end

    def test_null_user_has_id
      assert_equal 0, @subject.id
    end

    def test_null_user_has_email
      assert_equal "null_user@sinatra.app", @subject.email
    end
  end
end
