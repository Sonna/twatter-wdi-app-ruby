# frozen_string_literal: true

require "test/test_helper"

class CommentsRoutesTest < CurrentUserSession
  def setup
    super
    @twat = Twat.create(message: "Twat CommentsRoutesTest",
                        user_id: current_user.id)
  end

  def teardown
    @twat&.destroy
  end

  def test_comment_create_record_route
    params = {
      content: "Comments Routes Test Content",
      twat_id: @twat.id,
      user_id: current_user.id
    }
    post "/comments", params
    assert last_response.status, be_redirect
  ensure
    Comment.find_by(params)&.destroy
  end
end
