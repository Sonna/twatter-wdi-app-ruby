# frozen_string_literal: true

require "test/test_helper"

class RetwatsRoutesTest < CurrentUserSession
  def setup
    super
    @retwatable_user = User.create(
      email: "retwatable@route.test", name: "retwat, so retwat",
      username: "really_retwats_me", password: "987654321asdf"
    )
    @retwatable_twat = Twat.create(
      message: "retwat, so retwat's twat", user_id: @retwatable_user.id
    )
  end

  def teardown
    @retwatable_twat&.destroy
    @retwatable_user&.destroy
  end

  def test_retwats_create_record_route
    params = { user_id: current_user.id, twat_id: @retwatable_twat.id }
    post "/retwats", params
    assert last_response.status, be_redirect
  ensure
    Retwat.find_by(params)&.destroy
  end

  def test_retwats_destroy_record_route
    retwat = Retwat.find_or_create_by(
      user_id: current_user.id, twat_id: @retwatable_twat.id
    )
    delete "/retwats/#{retwat.id}"
    assert last_response.status, be_redirect
  ensure
    retwat&.destroy
  end
end
