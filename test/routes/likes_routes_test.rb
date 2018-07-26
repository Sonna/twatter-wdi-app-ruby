# frozen_string_literal: true

require "test/test_helper"

class LikesRoutesTest < CurrentUserSession
  def setup
    super
    @likeable_user = User.create(
      email: "likeable@route.test", name: "Like, so Like",
      username: "really_likes_me", password: "987654321asdf"
    )
    @likeable_twat = Twat.create(
      message: "Like, so Like's twat", user_id: @likeable_user.id
    )
  end

  def teardown
    @likeable_twat&.destroy
    @likeable_user&.destroy
  end

  def test_likes_create_record_route
    params = { user_id: current_user.id, twat_id: @likeable_twat.id }
    post "/likes", params
    assert last_response.status, be_redirect
  ensure
    Like.find_by(params)&.destroy
  end

  def test_likes_destroy_record_route
    like = Like.find_or_create_by(
      user_id: current_user.id, twat_id: @likeable_twat.id
    )
    delete "/likes/#{like.id}"
    assert last_response.status, be_redirect
  ensure
    like&.destroy
  end
end
