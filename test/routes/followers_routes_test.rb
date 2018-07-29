# frozen_string_literal: true

require "test/test_helper"

class FollowersRoutesTest < CurrentUserSession
  def test_show_users_followers_route
    get "/followers/#{current_user.username}"
    assert last_response.ok?
  end
end
