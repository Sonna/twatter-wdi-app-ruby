# frozen_string_literal: true

require "test_helper"

# class UserCanSignInTest < Minitest::Test
# class UserCanSignInTest < Minitest::Capybara::Test
class UserCanSignInTest < CapybaraTestCase
  # include FeatureHelpers

  def setup
    visit "/logout"
  end

  def test_user_can_signup
    user = MockUser.new("test@email.com", "Test User", "testusername",
                        "password")
    signup(user)
    # assert_equal selector("nav.navigation .user"),
    # "logged in as test@email.com"
    refute page.has_content?("logged in as test@email.com")
    assert page.has_content?("login"), page
  end

  def test_user_can_login
    user = MockUser.new("test@email.com", "Test User", "testusername",
                        "password")
    User.create(user.to_h)

    signin(user.email, user.password)

    assert page.has_content?("logged in as test@email.com")
    assert page.has_content?("logout")
  ensure
    attributes = user.to_h
    attributes.delete(:password)
    User.find_by(attributes).destroy
  end
end
