# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

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
    unless (user = User.find_by(email: user_details[:email]))
      user = User.new(user_details)

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

  # Override this method to change Users between tests
  def user_details
    {
      username: "testuser", email: "test@sinatra.app",
      name: "Test User", password: "password"
    }
  end
end
