# frozen_string_literal: true

require "test/test_helper"

module Models
  class RetwatTest < Minitest::Test
    def setup
      @ronald = User.create(email: "ronald@email.com", name: "Test ronald",
                            username: "testronald", password: "password")
      @susan = User.create(email: "susan@email.com", name: "Test susan",
                           username: "testsusan", password: "password")
    end

    def teardown
      @ronald&.destroy
      @susan&.destroy
    end

    def test_susan_can_retwats_ronalds_twat
      subject = Twat.create(message: "ronald's eat shoots' leaves",
                            user_id: @ronald.id)

      assert described_class.create(twat_id: subject.id, user_id: @susan.id)
    ensure
      subject&.destroy
    end

    def test_ronald_twats_retwat_count_increases
      subject = Twat.create(message: "ronald's eat shoots' leaves",
                            user_id: @ronald.id)
      assert_equal 0, subject.retwats_count

      described_class.create(twat_id: subject.id, user_id: @susan.id)
      assert_equal 1, subject.reload.retwats_count
    ensure
      subject&.destroy
    end

    def test_retwated_by_returns_retwatter_user
      twat = Twat.create(message: "A popular message", user_id: @ronald.id)
      subject = described_class.create(twat_id: twat.id, user_id: @susan.id)

      assert_equal subject.retwated_by, @susan
    ensure
      subject&.destroy
      twat&.destroy
    end

    protected

    def described_class
      Retwat
    end
  end
end
