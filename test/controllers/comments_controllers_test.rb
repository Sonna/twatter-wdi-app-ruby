# frozen_string_literal: true

require "test/test_helper"

class CommentsControllersTest < CurrentUserSession
  def setup
    super
    @twat = Twat.create(message: "Twat CommentsControllersTest",
                        user_id: current_user.id)
  end

  def teardown
    @twat&.destroy
  end

  def test_comment_create_record_action
    params = {
      content: "Comments Controllers Test Content",
      twat_id: @twat.id,
      user_id: current_user.id
    }

    post "/comments", params
    follow_redirect!

    assert last_response.body.include?("Comments Controllers Test Content"),
           last_response.body
  ensure
    Comment.find_by(params)&.destroy
  end
end
