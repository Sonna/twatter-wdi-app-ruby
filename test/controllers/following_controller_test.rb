# frozen_string_literal: true

require "test/test_helper"

class FollowingControllerTest < CurrentUserSession
  def setup
    super
  end

  def test_show_following_record_action
    weiss = User.create(email: "weiss@email.com", name: "Test weiss",
                        username: "testweiss", password: "password")
    followed_user = FollowedUser.create(user_id: weiss.id,
                                        follower_id: current_user.id)

    get "/following/#{current_user.username}"
    assert last_response.body.include?("@testweiss")
  ensure
    followed_user&.destroy
    weiss&.destroy
  end
end
