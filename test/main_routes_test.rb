# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "test/test_helper"

require "main"

class MainRoutesTest < CurrentUserSession
  def test_twats_route
    get "/twats"
    assert last_response.ok?
    assert last_response.body.include?("Twatter")
  end
end
