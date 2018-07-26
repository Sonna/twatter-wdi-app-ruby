# frozen_string_literal: true

require "test/test_helper"

class BlockedUsersRoutesTest < CurrentUserSession
  def setup
    super
    @blockable_user = User.create(
      email: "blockable@route.test", name: "Blocky 2",
      username: "blocks_me", password: "987654321asdf"
    )
  end

  def teardown
    @blockable_user.destroy
  end

  def test_blocked_users_create_record_route
    params = { user_id: current_user.id, blocker_id: @blockable_user.id }
    post "/blocks", params
    assert last_response.status, be_redirect
  ensure
    BlockedUser.find_by(params)&.destroy
  end

  def test_blocked_users_destroy_record_route
    blocked_user = BlockedUser.find_or_create_by(
      user_id: current_user.id, blocker_id: @blockable_user.id
    )
    delete "/blocks/#{blocked_user.id}"
    assert last_response.status, be_redirect
  ensure
    blocked_user&.destroy
  end
end
