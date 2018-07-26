# frozen_string_literal: true

require "test/test_helper"

class SessionsAppRoutesTest < CurrentUserSession
  def test_signup_route
    get "/signup"
    assert last_response.ok?
  end

  def test_login_route
    get "/login"
    assert last_response.ok?
  end
end
