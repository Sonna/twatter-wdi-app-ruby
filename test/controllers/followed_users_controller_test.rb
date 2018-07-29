# frozen_string_literal: true

require "test/test_helper"

require "main"

class FollowedUsersControllerTest < CurrentUserSession
  def setup
    super
    @followable_user = User.create(
      email: "followable@controller.test", name: "followy",
      username: "followable", password: "abcdefg123456"
    )
    @followable_twat = Twat.create(
      message: "followable_user's twat", user_id: @followable_user.id
    )
  end

  def teardown
    @followable_twat.destroy
    @followable_user.destroy
  end

  def test_followed_user_create_record_action
    params = { user_id: current_user.id, follower_id: @followable_user.id }

    post "/follows", params
    follow_redirect!
    # get "/"

    assert last_response.body.include?("followable_user's twat"),
           last_response.body
  ensure
    FollowedUser.find_by(params)&.destroy
  end

  def test_followed_user_destroy_record_action
    followed_user = FollowedUser.find_or_create_by(
      user_id: current_user.id, follower_id: @followable_user.id
    )

    delete "/follows/#{followed_user.id}"
    follow_redirect!
    # get "/"

    refute last_response.body.include?("followable_user's twat")
  ensure
    followed_user&.destroy
  end
end
