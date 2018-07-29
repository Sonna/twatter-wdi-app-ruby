# frozen_string_literal: true

require "test/test_helper"

class FollowedUsersRoutesTest < CurrentUserSession
  def setup
    super
    @followable_user = User.create(
      email: "followable@route.test", name: "followy 2",
      username: "follows_me", password: "987654321asdf"
    )
  end

  def teardown
    @followable_user.destroy
  end

  def test_followed_users_create_record_route
    params = { user_id: current_user.id, follower_id: @followable_user.id }
    post "/follows", params
    assert last_response.status, be_redirect
  ensure
    FollowedUser.find_by(params)&.destroy
  end

  def test_followed_users_destroy_record_route
    followed_user = FollowedUser.find_or_create_by(
      user_id: current_user.id, follower_id: @followable_user.id
    )
    delete "/follows/#{followed_user.id}"
    assert last_response.status, be_redirect
  ensure
    followed_user&.destroy
  end
end
