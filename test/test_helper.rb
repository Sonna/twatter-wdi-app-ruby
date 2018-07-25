# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "minitest/autorun"
require "rack/test"

require "main"

class CurrentUserSession < Minitest::Test
  include Rack::Test::Methods

  def app
    # Sinatra::Application
    TwatterApp
  end

  def current_user_session
    get "/", {}, "rack.session" => { user_id: current_user.id }
  end

  def current_user
    unless (user = User.find_by(email: "test@sinatra.app"))
      user = User.new(username: "testuser", email: "test@sinatra.app",
                      name: "Test User")
      user.password = "password"
      user.save
    end
    user
  end

  def setup
    current_user_session
  end

  def be_redirect
    302
  end
end
