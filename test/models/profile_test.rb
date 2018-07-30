# frozen_string_literal: true

require "test/test_helper"

module Models
  class ProfileTest < Minitest::Test
    def setup
      @xenia = User.create(email: "Xenia@email.com", name: "Test Xenia",
                           username: "testXenia", password: "password")
      @subject = @xenia.profile
    end

    def teardown
      @xenia.destroy
    end

    def test_profile_has_image_url
      assert @subject.respond_to?(:image_url)
    end

    def test_profile_has_twats_count
      assert @subject.respond_to?(:twats_count)
    end

    def test_profile_has_followers_count
      assert @subject.respond_to?(:followers_count)
    end

    def test_profile_has_following_count
      assert @subject.respond_to?(:following_count)
    end

    def test_profile_has_twats_count_starts_at_zero
      assert @subject.twats_count.zero?
    end

    def test_profile_has_followers_count_starts_at_zero
      assert @subject.followers_count.zero?
    end

    def test_profile_has_following_count_starts_at_zero
      assert @subject.following_count.zero?
    end

    def test_returns_attributes_hash_with_fullname
      assert @subject.attributes >= { "name" => "Test Xenia" }
    end

    def test_returns_attributes_hash_with_username
      assert @subject.attributes >= { "username" => "testXenia" }
    end
  end
end
