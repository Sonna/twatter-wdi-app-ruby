# frozen_string_literal: true

require "test/test_helper"

module Templates
  module Users
    class ProfileCardTemplateTest < Minitest::Test
      include TemplateTestTool

      def setup
        @subject = erb(:"users/profile_card",
                       LocalsStub.new(:@name => "Alex Sonneveld",
                                      :@username => "AlexSonneveld",
                                      :@image_url => "/images/avatar3.png",
                                      :@twats_count => 5,
                                      :@following_count => 41,
                                      :@followers_count => 8))
      end

      def teardown
        @subject = nil
      end

      def test_render_user_profile_card_partial_template
        assert_match(
          %r{<article class="user-profile-card">(.|\n)*</article>},
          @subject
        )
      end

      def test_user_profile_card_template_contains_name
        assert_match(/Alex Sonneveld/, @subject)
      end

      def test_user_profile_card_template_contains_username
        assert_match(/@AlexSonneveld/, @subject)
      end

      def test_user_profile_card_template_contains_avatar_image
        assert_match(%r{<img src="/images/avatar3.png">}, @subject)
      end

      def test_user_profile_card_template_contains_twat_count
        assert_match(%r{Twats <span class="twats-count">5</span>}, @subject)
      end

      def test_user_profile_card_template_contains_following_count
        assert_match(
          %r{Following <span class="followings-count">41</span>},
          @subject
        )
      end

      def test_user_profile_card_template_contains_followers_count
        assert_match(
          %r{Followers <span class="followers-count">8</span>},
          @subject
        )
      end
    end
  end
end
