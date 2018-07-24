# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

require "apps/sessions/sessions_app"
require "test/test_helper"

class SessionAppTest < CurrentUserSession
  def app
    SessionsApp
  end

  def test_login
    get "/login"

    assert_equal current_user.id, last_request.env["rack.session"]["user_id"]
    assert last_response.ok?
  end
end
