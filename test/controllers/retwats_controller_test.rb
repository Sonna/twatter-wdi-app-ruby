# frozen_string_literal: true

require "test/test_helper"

require "main"

class RetwatsControllerTest < CurrentUserSession
  def setup
    super
    @retwatable_user = User.create(
      email: "retwatable@action.test", name: "retwat, so retwat",
      username: "really_retwats_me", password: "987654321asdf"
    )
    @retwatable_twat = Twat.create(
      message: "retwat, so retwat's twat", user_id: @retwatable_user.id
    )
    @retwating_user = User.create(
      email: "retwating@action.test", name: "For whom does the follow toll",
      username: "can_see_me_retwats", password: "987654321asdf"
    )
    # @following_user = User.create(
    #   email: "following@action.test", name: "For whom does the follow toll",
    #   username: "can_see_me_retwats", password: "987654321asdf"
    # )
    @followed_user = FollowedUser.create(user_id: @retwating_user.id,
                                         follower_id: current_user.id)
    # @followed_retwat = FollowedUser.create(user_id: @following_user.id,
    #                                        follower_id: @retwatable_user.id)
  end

  def teardown
    # @followed_retwat&.destroy
    @followed_user&.destroy
    @retwating_user&.destroy
    # @following_user&.destroy
    @retwatable_twat&.destroy
    @retwatable_user&.destroy
  end

  def test_retwats_create_record_action
    params = { user_id: @retwating_user.id, twat_id: @retwatable_twat.id }

    post "/retwats", params, "rack.session" => { user_id: @retwating_user.id }
    # follow_redirect!
    # get "/"
    current_user_session

    assert_match Regexp.new(
      '<span class="retwated-by">(.|\n)*' \
        "#{@retwating_user.username}" \
        '(.|\n)*Retwated(.|\n)*</span>'
    ), last_response.body
  ensure
    Retwat.find_by(params)&.destroy
  end

  def test_retwats_destroy_record_action
    retwat = Retwat.find_or_create_by(
      user_id: @retwating_user.id, twat_id: @retwatable_twat.id
    )

    delete "/retwats/#{retwat.id}", {}, "rack.session" => {
      user_id: @retwating_user.id
    }
    # follow_redirect!
    # get "/"
    current_user_session

    refute_match Regexp.new(
      '<span class="retwated-by">(.|\n)*' \
        "#{@retwating_user.username}" \
        '(.|\n)*Retwated(.|\n)*</span>'
    ), last_response.body
  ensure
    retwat&.destroy
  end
end
