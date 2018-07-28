# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class CanLoginTest < CapybaraTestCase
    def setup
      visit "/logout"
    end

    def test_user_can_login
      user = User.create(email: "canlogin@email.com", name: "CanLogin Test",
                         username: "canlogintest", password: "password")

      login(user.email, "password")

      assert page.has_content?("logged in as @canlogintest")
      # assert page.has_content?("CanLogin Test")
      # assert page.has_content?("@canlogintest")
      assert page.has_content?("logout")
    ensure
      user&.destroy
    end
  end
end
