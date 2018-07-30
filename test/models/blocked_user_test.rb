# frozen_string_literal: true

require "test/test_helper"

module Models
  class BlockedUserTest < Minitest::Test
    def setup
      @neil = User.create(email: "neil@email.com", name: "Test neil",
                          username: "testneil", password: "password")
      @olive = User.create(email: "olive@email.com", name: "Test olive",
                           username: "testolive", password: "password")
      @neil_blocks_olive = BlockedUser.create(user_id: @olive.id,
                                              blocker_id: @neil.id)
    end

    def teardown
      @neil_blocks_olive&.destroy
      @neil.destroy
      @olive.destroy
    end

    def test_neil_blocks_olives_record
      assert BlockedUser.find_by(user_id: @olive.id, blocker_id: @neil.id)
    end

    def test_neil_has_blocking_association_with_olive
      assert_includes @neil.blocking.pluck(:user_id), @olive.id
    end

    def test_olive_has_blocker_association_with_neil
      assert_includes @olive.blockers.pluck(:user_id), @neil.id
    end
  end
end
