# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class DirectMessageOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @anna = MockUser.new("anna@email.com", "Test User", "testusername",
                           "password")
      @messenger = MockUser.new("messenger@email.com", "Test messenger",
                                "testmessenger", "password")
      anna = User.create(@anna.to_h)
      messenger = User.create(@messenger.to_h)

      @anna_twat = Twat.create(message: "Anna twat message", user_id: anna.id)
      @messenger_twat =
        Twat.create(message: "messenger's content", user_id: messenger.id)
    end

    def teardown
      cleanup_user_data(@anna)
      cleanup_user_data(@messenger)
      @anna_twat.destroy
      @messenger_twat.destroy
    end

    def test_user_can_find_the_direct_message_button
      login(@messenger.email, @messenger.password)
      assert find("#twat-#{@anna_twat.id}", text: "Direct Message")
    end

    def test_user_cannot_find_the_direct_message_button_for_their_own_twats
      login(@anna.email, @anna.password)
      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@anna_twat.id}", text: "Direct Message")
      end
    end
  end
end
