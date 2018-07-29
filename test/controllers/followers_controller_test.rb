# frozen_string_literal: true

require "test/test_helper"

class FollowersControllerTest < CurrentUserSession
  def setup
    super
  end

  def test_show_followers_record_action
    venn = User.create(email: "venn@email.com", name: "Test venn",
                       username: "testvenn", password: "password")
    followed_user = FollowedUser.create(user_id: current_user.id,
                                        follower_id: venn.id)

    get "/followers/#{current_user.username}"
    assert last_response.body.include?("@testvenn")
  ensure
    followed_user&.destroy
    venn&.destroy
  end
end
