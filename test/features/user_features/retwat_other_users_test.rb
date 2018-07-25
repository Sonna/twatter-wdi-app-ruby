# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class RetwatOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @bob = MockUser.new("bob@email.com", "Test Bob", "testbob", "password")
      @carol = MockUser.new("carol@email.com", "Test Carol", "testcarol",
                            "password")
      bob = User.create(@bob.to_h)
      carol = User.create(@carol.to_h)

      @bob_twat = Twat.create(message: "bob twat message", user_id: bob.id)
      @carol_twat = Twat.create(message: "carol's content", user_id: carol.id)
    end

    def teardown
      cleanup_user_data(@bob)
      cleanup_user_data(@carol)
      @bob_twat.destroy
      @carol_twat.destroy
    end

    def test_user_can_find_the_retwat_message_button
      login(@carol.email, @carol.password)
      assert find("#twat-#{@bob_twat.id}", text: "Retwat")
    end

    def test_user_cannot_find_the_retwat_message_button_for_their_own_twats
      login(@bob.email, @bob.password)
      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@bob_twat.id}", text: "Retwat")
      end
    end
  end
end
