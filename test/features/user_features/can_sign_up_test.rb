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

      assert page.has_content?("logged in as @testusername")
    ensure
      User.find_by(email: "test@email.com", name: "Test User",
                   username: "testusername")&.destroy
    end
  end
end
