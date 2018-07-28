# frozen_string_literal: true

require "test_helper"

module LikeFeatures
  class CreateNewLikeTest < CapybaraTestCase
    def setup
      visit "/logout"

      @luke = User.create(email: "Luke@email.com", name: "Test Luke",
                          username: "testluke", password: "LukeLukeLukeLuke")

      @mary = User.create(email: "mary@email.com", name: "Test mary",
                          username: "testmary", password: "marymarymarymary")

      @marys_twat = Twat.create(message: "marys_twat", user_id: @mary.id)

      login(@luke.email, @luke.password)
    end

    def teardown
      @marys_twat&.destroy
      @luke&.destroy
      @mary&.destroy
    end

    def test_user_can_find_a_like_button_for_marys_twat
      visit "/users/#{@mary.username}"
      assert_match(/Like/, page.find(".like-#{@marys_twat.id} button").text,
                   page.html)
    end

    def test_user_can_like_marys_twat
      visit "/users/#{@mary.username}"
      within(".like-#{@marys_twat.id}") { click_on "Like" }
      visit "/users/#{@mary.username}"

      like = Like.find_by(twat_id: @marys_twat.id)
      assert_match(/Unlike/, page.find(".unlike-#{like.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end

    def test_user_can_find_an_unlike_button_for_marys_twat
      like = Like.create(user_id: @luke.id, twat_id: @marys_twat.id)
      visit "/users/#{@mary.username}"
      assert_match(/Unlike/, page.find(".unlike-#{like.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end

    def test_user_can_unlike_marys_twat
      like = Like.create(user_id: @luke.id, twat_id: @marys_twat.id)

      visit "/users/#{@mary.username}"
      within(".unlike-#{like.id}") { click_on "Unlike" }
      visit "/users/#{@mary.username}"

      assert_match(/Like/, page.find(".like-#{@marys_twat.id} button").text,
                   page.html)
    ensure
      like&.destroy
    end
  end
end
