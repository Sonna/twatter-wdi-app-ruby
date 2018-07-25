# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class CanSignUpTest < CapybaraTestCase
    def setup
      visit "/logout"
    end

    def test_user_can_signup
      user = MockUser.new("test@email.com", "Test User", "testusername",
                          "password")

      signup(user)

      refute page.has_content?("logged in as test@email.com")
      assert page.has_content?("login"), page
    end
  end
end
