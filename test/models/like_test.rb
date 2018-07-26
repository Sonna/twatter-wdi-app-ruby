# frozen_string_literal: true

require "test/test_helper"

module Models
  class LikeTest < Minitest::Test
    def setup
      @daniel = User.create(email: "daniel@email.com", name: "Test daniel",
                            username: "testdaniel", password: "password")
      @elly = User.create(email: "elly@email.com", name: "Test elly",
                          username: "testelly", password: "password")

      @daniel_twat = Twat.create(message: "daniel's twat", user_id: @daniel.id)
      @elly_twat = Twat.create(message: "elly's twat", user_id: @elly.id)
    end

    def teardown
      @daniel_twat.destroy
      @elly_twat.destroy
      @daniel.destroy
      @elly.destroy
    end

    def test_daniel_likes_ellys_twat_record
      assert Like.create(user_id: @daniel.id, twat_id: @elly_twat.id)
    end

    def test_elly_likes_daniels_twat_record
      assert Like.create(user_id: @elly.id, twat_id: @daniel_twat.id)
    end
  end
end
