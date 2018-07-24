# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "test/test_helper"

require "main"

class TwatterAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TwatterApp
  end

  def test_my_default
    get "/"
    assert last_response.ok?
    assert last_response.body.include?("Twatter")
  end

  # def test_with_params
  #   get "/meet", name: "Frank"
  #   assert_equal "Hello Frank!", last_response.body
  # end

  # def test_with_user_agent
  #   get "/", {}, "HTTP_USER_AGENT" => "Songbird"
  #   assert_equal "You're using Songbird!", last_response.body
  # end
end
