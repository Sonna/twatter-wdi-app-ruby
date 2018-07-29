# frozen_string_literal: true

require "test/test_helper"

class FollowingRoutesTest < CurrentUserSession
  def test_show_users_following_route
    get "/following/#{current_user.username}"
    assert last_response.ok?
  end
end
