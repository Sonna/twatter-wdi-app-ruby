# frozen_string_literal: true

require "test_helper"

module Models
  class MessageTest < Minitest::Test
    def setup
      @tedd = User.create(email: "tedd@test.com", name: "Tedd User",
                          username: "tedd", password: "password")
      @ursa = User.create(email: "ursa@test.com", name: "Ursa User",
                          username: "ursa", password: "password")
      @subject = Message.create(to: @tedd, from: @ursa, content: "is a test")
    end

    def teardown
      @subject.destroy
      @tedd.destroy
      @ursa.destroy
    end

    class WhenAMessageIsSentFromUrsaToTedd < MessageTest
      def test_is_from_ursa
        assert_equal @subject.from, @ursa
      end

      def test_is_to_tedd
        assert_equal @subject.to, @tedd
      end

      def test_contains_content
        assert_equal @subject.content, "is a test"
      end

      def test_retrieve_a_conversation_just_between_tedd_and_ursa
        tedd2ursa = Message.create(from: @tedd, to: @ursa, content: "is a test")
        other = Message.create(content: "ignore this message to & from no-one")

        conversation = Message.between(@tedd, @ursa)

        assert_includes conversation, @subject
        assert_includes conversation, tedd2ursa
        refute_includes conversation, other
      ensure
        tedd2ursa&.destroy
        other&.destroy
      end
    end
  end
end
