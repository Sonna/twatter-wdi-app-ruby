# frozen_string_literal: true

require "test/test_helper"

require "main"

class LikesControllerTest < CurrentUserSession
  def setup
    super
    @likeable_user = User.create(
      email: "likeable@controller.test", name: "Like Like",
      username: "likeable", password: "abcdefg123456"
    )
    @likeable_twat = Twat.create(
      message: "likeable_user's twat", user_id: @likeable_user.id
    )
  end

  def teardown
    @likeable_twat&.destroy
    @likeable_user&.destroy
  end

  def test_like_create_record_action
    params = { twat_id: @likeable_twat.id }

    post "/likes", params
    follow_redirect!

    # assert last_response.body.include?("Like 1")
    # refute last_response.body.include?("Like 0")
    assert last_response.body.include?(<<-HTML)
          <span class="sr-only">Unlike</span>
          <span class="count">1</span>
    HTML
  ensure
    Like.find_by(params)&.destroy
  end

  def test_like_destroy_record_action
    like = Like.find_or_create_by(
      user_id: current_user.id, twat_id: @likeable_twat.id
    )

    delete "/likes/#{like.id}"
    follow_redirect!

    # assert last_response.body.include?("Like 0")
    # refute last_response.body.include?("Like 1")
    assert last_response.body.include?(<<-HTML)
          <span class="sr-only">Like</span>
          <span class="count">0</span>
    HTML
  ensure
    like&.destroy
  end
end
