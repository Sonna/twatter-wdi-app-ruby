# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class BlockOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @user = MockUser.new("user@email.com", "Test User", "testusername",
                           "password")
      @blocker = MockUser.new("blocker@email.com", "Test Blocker",
                              "testblocker", "password")
      user = User.create(@user.to_h)
      blocker = User.create(@blocker.to_h)

      @user_twat = Twat.create(message: "Mesage is visible", user_id: user.id)
      @blocker_twat =
        Twat.create(message: "You cannot see me", user_id: blocker.id)
    end

    def teardown
      cleanup_user_data(@user)
      cleanup_user_data(@blocker)
      @user_twat.destroy
      @blocker_twat.destroy
    end

    def test_user_can_find_the_block_button
      login(@blocker.email, @blocker.password)
      assert find("#twat-#{@user_twat.id}", text: "Block")
    end

    def test_user_cannot_find_the_block_button_for_their_own_twats
      login(@user.email, @user.password)
      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@user_twat.id}", text: "Block")
      end
    end

    def test_blocker_can_block_another_user_from_seeing_their_twats
      login(@blocker.email, @blocker.password)
      within("#twat-#{@user_twat.id}") { click_on "Block" }
      refute page.has_content?("Mesage is visible")
    end

    def test_a_blocked_user_cannot_see_blockers_twats
      login(@blocker.email, @blocker.password)
      within("#twat-#{@user_twat.id}") { click_on "Block" }
      # within(".block-twatter-#{@user.id}") { click_on "Block" }
      visit "/logout"

      login(@user.email, @user.password)
      refute page.has_content?("You cannot see me")
    end
  end
end
