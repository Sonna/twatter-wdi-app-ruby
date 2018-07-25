# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "test/test_helper"

require "main"

class MainRoutesTest < CurrentUserSession
  def test_root_path_route
    get "/"
    assert last_response.ok?
  end
end
