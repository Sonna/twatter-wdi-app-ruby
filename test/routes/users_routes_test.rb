# frozen_string_literal: true

require "test/test_helper"

class UsersRoutesTest < CurrentUserSession
  def test_users_show_twats_route
    jack = User.create(
      email: "jack@routes.test", name: "Jack Gaint",
      username: "jack", password: "abcdefg123456"
    )
    get "/users/#{jack.username}"
    assert last_response.ok?
  ensure
    jack&.destroy
  end
end
