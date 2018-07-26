# frozen_string_literal: true

require "test/test_helper"

class UsersControllerTest < CurrentUserSession
  def setup
    super
  end

  def test_user_show_record_action
    kiri = User.create(email: "kiri@email.com", name: "Test kiri",
                       username: "testkiri", password: "password")
    twat = Twat.find_or_create_by(user_id: kiri.id,
                                  message: "test_user_show_record_action")
    get "/users/#{kiri.username}"
    assert last_response.body.include?("test_user_show_record_action")
  ensure
    twat&.destroy
    kiri&.destroy
  end
end
