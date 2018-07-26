# frozen_string_literal: true

require "test/test_helper"

module Models
  class UserTest < Minitest::Test
    def setup
      @subject = User.create(email: "fred@email.com", name: "Test fred",
                             username: "testfred", password: "password")
    end

    def teardown
      @subject.destroy
    end

    def test_user_has_name
      assert @subject.respond_to?(:name)
    end

    def test_user_has_username
      assert @subject.respond_to?(:username)
    end

    def test_user_has_email
      assert @subject.respond_to?(:email)
    end

    def test_user_has_password_digest
      assert @subject.respond_to?(:password_digest)
    end

    def test_user_has_twats_count
      assert @subject.respond_to?(:twats_count)
    end

    def test_user_has_followers_count
      assert @subject.respond_to?(:followers_count)
    end

    def test_user_has_following_count
      assert @subject.respond_to?(:following_count)
    end

    def test_user_email_is_unique
      refute User.new(email: "fred@email.com", name: "Test fred",
                      username: "nottestfred", password: "password").valid?
    end

    def test_user_username_is_unique
      refute User.new(email: "notfred@email.com", name: "Test fred",
                      username: "testfred", password: "password").valid?
    end

    def test_user_must_have_a_name
      refute User.new(
        email: "fred@email.com", username: "nottestfred", password: "password"
      ).valid?
    end

    def test_user_must_have_a_username
      refute User.new(
        email: "notfred@email.com", name: "Test fred", password: "password"
      ).valid?
    end

    def test_user_must_have_a_email
      refute User.new(
        name: "Test fred", username: "testfred", password: "password"
      ).valid?
    end

    def test_user_must_have_a_password
      refute User.new(
        email: "notfred@email.com", name: "Test fred", username: "testfred"
      ).valid?
    end
  end
end
