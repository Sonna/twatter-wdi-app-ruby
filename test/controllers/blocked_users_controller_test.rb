# frozen_string_literal: true

require "test/test_helper"

require "main"

class BlockedUsersControllerTest < CurrentUserSession
  def setup
    super
    @blockable_user = User.create(
      email: "blockable@controller.test", name: "Blocky",
      username: "blockable", password: "abcdefg123456"
    )
    @blockable_twat = Twat.create(
      message: "blockable_user's twat", user_id: @blockable_user.id
    )
  end

  def teardown
    @blockable_twat.destroy
    @blockable_user.destroy
  end

  def test_blocked_user_create_record_action
    params = { user_id: current_user.id, blocker_id: @blockable_user.id }

    post "/blocks", params
    follow_redirect!

    refute last_response.body.include?("@#{@blockable_user.username}"),
           last_response.body
  ensure
    BlockedUser.find_by(params)&.destroy
  end

  def test_blocked_user_destroy_record_action
    blocked_user = BlockedUser.find_or_create_by(
      user_id: current_user.id, blocker_id: @blockable_user.id
    )

    delete "/blocks/#{blocked_user.id}"
    follow_redirect!

    assert last_response.body.include?("@#{@blockable_user.username}")
  ensure
    blocked_user&.destroy
  end
end
