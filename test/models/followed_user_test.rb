# frozen_string_literal: true

require "test/test_helper"

module Models
  class FollowedUserTest < Minitest::Test
    def setup
      @grace = User.create(email: "grace@email.com", name: "Test grace",
                           username: "testgrace", password: "password")
      @harry = User.create(email: "harry@email.com", name: "Test harry",
                           username: "testharry", password: "password")
      @grace_follows_harry = FollowedUser.create(user_id: @harry.id,
                                                 follower_id: @grace.id)
    end

    def teardown
      @grace_follows_harry&.destroy
      @grace.destroy
      @harry.destroy
    end

    def test_grace_follows_harrys_record
      assert FollowedUser.find_by(user_id: @harry.id, follower_id: @grace.id)
    end

    def test_grace_has_following_association_with_harry
      assert_includes @grace.following, @harry
    end

    def test_harry_has_follower_association_with_grace
      assert_includes @harry.followers, @grace
    end
  end
end
