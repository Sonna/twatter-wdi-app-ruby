# frozen_string_literal: true

require "test_helper"

module UserFeatures
  class BlockOtherUsersTest < CapybaraTestCase
    def setup
      visit "/logout"

      @bill = User.create(
        email: "bill@email.com", name: "Test Bill",
        username: "bill", password: "password"
      )
      @blocker = User.create(
        email: "blocker@email.com", name: "Test Blocker",
        username: "testblocker", password: "password"
      )
      @bill_twat = Twat.create(message: "Mesage is visible", user_id: @bill.id)
      @blocker_twat =
        Twat.create(message: "You cannot see me", user_id: @blocker.id)
    end

    def teardown
      @bill_twat&.destroy
      @blocker_twat&.destroy
      @bill&.destroy
      @blocker&.destroy
    end

    def test_bill_can_find_the_block_button
      login(@blocker.email, @blocker.password)
      visit "/users/#{@bill.username}"
      assert find("#twat-#{@bill_twat.id}", text: "Block")
    end

    def test_bill_cannot_find_the_block_button_for_their_own_twats
      login(@bill.email, @bill.password)
      visit "/users/#{@bill.username}"

      assert_raises(Capybara::ElementNotFound) do
        find("#twat-#{@bill_twat.id}", text: "Block")
      end
    end

    def test_blocker_can_block_bill_from_seeing_their_twats
      login(@blocker.email, @blocker.password)

      visit "/users/#{@bill.username}"
      within("#twat-#{@bill_twat.id}") { click_on "Block" }

      visit "/users/#{@bill.username}"
      refute page.has_content?("Mesage is visible")
    ensure
      blocked = BlockedUser.find_by(user_id: @blocker.id, blocker_id: @bill.id)
      blocked&.destroy
    end

    def test_blocked_user_bill_cannot_see_blockers_twats
      login(@blocker.email, @blocker.password)
      visit "/users/#{@bill.username}"
      within("#twat-#{@bill_twat.id}") { click_on "Block" }
      # within(".block-twatter-#{@bill.id}") { click_on "Block" }
      visit "/logout"

      login(@bill.email, @bill.password)
      visit "/users/#{@blocker.username}"

      refute page.has_content?("You cannot see me")
    ensure
      blocked = BlockedUser.find_by(user_id: @blocker.id, blocker_id: @bill.id)
      blocked&.destroy
    end
  end
end
