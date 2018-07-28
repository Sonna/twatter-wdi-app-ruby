# frozen_string_literal: true

require "test_helper"

module TwatFeatures
  class CreateNewTwatTest < CapybaraTestCase
    def setup
      visit "/logout"

      @zoe = User.create(email: "zoe@email.com", name: "Test Zoe",
                         username: "zoe", password: "password")
      login(@zoe.email, @zoe.password)
    end

    def teardown
      @zoe.destroy
    end

    def test_zoe_can_find_the_call_to_action_on_the_homepage
      visit "/"
      # assert page.has_content?("What's happening?")
      assert_equal page.find_field("message")["placeholder"],
                   "What's happening?"
    end

    def test_zoe_can_create_a_new_twat
      message = "This is a test message for test_zoe_can_create_a_new_twat"

      visit "/"

      within("#twat-form") do
        fill_in "message", with: message
        click_on "post"
      end

      assert page.has_content?(message)
    ensure
      Twat.find_by(message: message)&.destroy
    end
  end
end
