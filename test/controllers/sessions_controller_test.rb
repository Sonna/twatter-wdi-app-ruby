# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

require "test/test_helper"

require "main"

class SessionsControllerTest < CurrentUserSession
  def test_signup_action
    get "/signup"
    assert last_response.body.include?("signup")
  end

  def test_login_action
    get "/login"
    assert last_response.body.include?("login")
  end
end
