# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

require "test/test_helper"

require "main"

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
