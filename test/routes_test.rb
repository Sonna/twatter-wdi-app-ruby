# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "test/test_helper"

require "main"

class TwatterAppRoutesTest < CurrentUserSession
  def test_my_default
    get "/"
    assert last_response.ok?
    assert last_response.body.include?("Twatter")
  end

  def test_twats_route
    get "/twats"
    assert last_response.ok?
    assert last_response.body.include?("Twatter")
  end

  def test_twats_reword_route
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_reword_route")
    get "/twats/#{twat.id}"
    assert last_response.ok?
    assert last_response.body.include?("test_twats_reword_route")
  ensure
    twat.destroy
  end

  def test_signup_route
    get "/signup"
    assert last_response.ok?
    assert last_response.body.include?("signup")
  end

  def test_login_route
    get "/login"
    assert last_response.ok?
    assert last_response.body.include?("login")
  end
end
