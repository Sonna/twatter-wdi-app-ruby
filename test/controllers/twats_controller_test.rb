# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("..", __dir__)

require "test/test_helper"

require "main"

class TwattsControllerTest < CurrentUserSession
  def test_twats_index_action
    get "/twats"
    assert last_response.body.include?("Twatter")
  end

  def test_twats_show_record_action
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_show_record_route")
    get "/twats/#{twat.id}"
    assert last_response.body.include?("test_twats_show_record_route")
  ensure
    twat.destroy
  end

  def test_twats_new_record_action
    get "/twats/new"
    assert last_response.body.include?("post new twat")
  end

  def test_twats_create_record_action
    params = { user_id: current_user.id,
               message: "test_twats_create_record_route" }

    post "/twats", params
    follow_redirect!

    assert last_response.body.include?("test_twats_create_record_route"),
           last_response.body
  ensure
    Twat.find_by(params)&.destroy
  end

  def test_twats_edit_record_action
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_record_route")
    get "/twats/#{twat.id}/edit"
    assert last_response.body.include?("test_twats_record_route")
  ensure
    twat&.destroy
  end

  def test_twats_update_record_action
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_preupdate_record_route")
    params = { message: "test_post-update_record_route" }

    put "/twats/#{twat.id}", params
    follow_redirect!

    assert last_response.body.include?("test_post-update_record_route"),
           last_response.body
  ensure
    twat&.destroy
  end

  def test_twats_destroy_record_action
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_destroy_record_route")

    delete "/twats/#{twat.id}"
    follow_redirect!

    refute last_response.body.include?("test_twats_destroy_record_route")
  ensure
    twat&.destroy
  end
end
