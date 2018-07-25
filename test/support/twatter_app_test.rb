# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

require "rack/test"

require "main"

class TwatterAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TwatterApp
  end
end
