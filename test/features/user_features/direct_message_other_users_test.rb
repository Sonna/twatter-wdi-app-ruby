# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class DirectMessageOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @anna = User.create(email: "anna@email.com", name: "Test User",
                          username: "anna", password: "password")
      @messe = User.create(email: "messe@email.com", name: "Test messe",
                           username: "messe", password: "password")

      @anna_twat = Twat.create(message: "Anna twat message", user_id: @anna.id)
    end

    def teardown
      @anna_twat&.destroy
      @anna&.destroy
      @messe&.destroy
    end

    def test_user_can_find_the_direct_message_button
      login(@messe.email, "password")
      visit "/users/#{@anna.username}"
      assert find("#twat-#{@anna_twat.id}", text: "Direct Message")
    end

    def test_user_cannot_find_the_direct_message_button_for_their_own_twats
      login(@anna.email, "password")
      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@anna_twat.id}", text: "Direct Message")
      end
    end
  end
end
