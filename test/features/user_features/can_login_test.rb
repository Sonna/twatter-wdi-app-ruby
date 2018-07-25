# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class CanLoginTest < CapybaraTestCase
    def setup
      visit "/logout"
    end

    def test_user_can_login
      user = MockUser.new("test@email.com", "Test User", "testusername",
                          "password")
      User.create(user.to_h)

      login(user.email, user.password)

      assert page.has_content?("logged in as test@email.com")
      assert page.has_content?("logout")
    ensure
      attributes = user.to_h
      attributes.delete(:password)
      User.find_by(attributes).destroy
    end
  end
end
