# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class BlockOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @user = User.create(
        email: "user@email.com", name: "Test User",
        username: "testusername", password: "password"
      )
      @blocker = User.create(
        email: "blocker@email.com", name: "Test Blocker",
        username: "testblocker", password: "password"
      )
      @user_twat = Twat.create(message: "Mesage is visible", user_id: @user.id)
      @blocker_twat =
        Twat.create(message: "You cannot see me", user_id: @blocker.id)
    end

    def teardown
      @user_twat&.destroy
      @blocker_twat&.destroy
      @user&.destroy
      @blocker&.destroy
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
    ensure
      blocked = BlockedUser.find_by(user_id: @blocker.id, blocker_id: @user.id)
      blocked&.destroy
    end

    def test_a_blocked_user_cannot_see_blockers_twats
      login(@blocker.email, @blocker.password)
      within("#twat-#{@user_twat.id}") { click_on "Block" }
      # within(".block-twatter-#{@user.id}") { click_on "Block" }
      visit "/logout"

      login(@user.email, @user.password)
      refute page.has_content?("You cannot see me")
    ensure
      blocked = BlockedUser.find_by(user_id: @blocker.id, blocker_id: @user.id)
      blocked&.destroy
    end
  end
end
