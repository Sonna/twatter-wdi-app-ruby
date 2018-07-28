# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class RetwatOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @bob = User.create(email: "bob@email.com", name: "Test Bob",
                         username: "testbob", password: "password")
      @carol = User.create(email: "carol@email.com", name: "Test Carol",
                           username: "testcarol", password: "password")

      @bob_twat = Twat.create(message: "bob twat message", user_id: @bob.id)
      @carol_twat = Twat.create(message: "carol's content", user_id: @carol.id)
    end

    def teardown
      @bob.destroy
      @carol.destroy
      @bob_twat.destroy
      @carol_twat.destroy
    end

    def test_user_can_find_the_retwat_message_button
      login(@carol.email, "password")
      visit "/users/#{@bob.username}"
      assert find("#twat-#{@bob_twat.id}", text: "Retwat")
    end

    def test_user_cannot_find_the_retwat_message_button_for_their_own_twats
      login(@bob.email, "password")
      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@bob_twat.id}", text: "Retwat")
      end
    end
  end
end
