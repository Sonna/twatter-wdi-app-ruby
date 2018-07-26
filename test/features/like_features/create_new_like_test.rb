# frozen_string_literal: true

require "test_helper"

module LikeFeatures
  class CreateNewLikeTest < CapybaraTestCase
    def setup
      visit "/logout"

      luke = MockUser.new("Luke@email.com", "Test Luke", "testluke",
                          "LukeLukeLukeLuke")
      @luke = User.create(luke.to_h)

      mary = MockUser.new("mary@email.com", "Test mary", "testmary",
                          "marymarymarymary")
      @mary = User.create(mary.to_h)

      @marys_twat = Twat.create(message: "marys_twat", user_id: @mary.id)

      login(@luke.email, @luke.password)
    end

    def teardown
      @marys_twat&.destroy
      @luke&.destroy
      @mary&.destroy
    end

    def test_user_can_find_a_like_button_for_marys_twat
      visit "/"
      assert_match(/Like/, page.find(".like-#{@marys_twat.id} button").text,
                   page.html)
    end

    def test_user_can_like_marys_twat
      visit "/"

      within("form.like-#{@marys_twat.id}") { click_on "Like" }

      like = Like.find_by(twat_id: @marys_twat.id)
      assert_match(/Unlike/, page.find(".unlike-#{like.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end

    def test_user_can_find_an_unlike_button_for_marys_twat
      like = Like.create(user_id: @luke.id, twat_id: @marys_twat.id)
      visit "/"
      assert_match(/Unlike/, page.find(".unlike-#{like.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end

    def test_user_can_unlike_marys_twat
      like = Like.create(user_id: @luke.id, twat_id: @marys_twat.id)
      visit "/"

      within("form.unlike-#{like.id}") { click_on "Unlike" }

      assert_match(/Like/, page.find(".like-#{@marys_twat.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end
  end
end
