# frozen_string_literal: true

require "test/test_helper"

module Models
  class CommentTest < Minitest::Test
    def setup
      @peter = User.create(email: "peter@email.com", name: "Test peter",
                           username: "testpeter", password: "password")
      @queeni = User.create(email: "queeni@email.com", name: "Test queeni",
                            username: "testqueeni", password: "password")

      @peter_twat = Twat.create(message: "peter's twat", user_id: @peter.id)
      @queeni_twat = Twat.create(message: "queeni's twat", user_id: @queeni.id)
    end

    def teardown
      @peter_twat.destroy
      @queeni_twat.destroy
      @peter.destroy
      @queeni.destroy
    end

    def test_peter_comments_on_queenis_twat_record
      comment = Comment.create(user_id: @peter.id, twat_id: @queeni_twat.id,
                               content: "peter commenting on queeni's twat")
      assert comment
    ensure
      comment&.destroy
    end

    def test_queeni_comments_on_peters_twat_record
      comment = Comment.create(user_id: @queeni.id, twat_id: @peter_twat.id,
                               content: "queeni commenting on peter's twat")
      assert comment
    ensure
      comment&.destroy
    end
  end
end
