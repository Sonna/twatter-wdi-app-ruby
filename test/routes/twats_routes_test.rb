# frozen_string_literal: true

require "test/test_helper"

class TwatsRoutesTest < CurrentUserSession
  def test_twats_index_route
    get "/twats"
    assert last_response.ok?, last_response.status
  end

  def test_twats_show_record_route
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_show_record_route")
    get "/twats/#{twat.id}"
    assert last_response.ok?
  ensure
    twat.destroy
  end

  def test_twats_new_record_route
    get "/twats/new"
    assert last_response.ok?
  end

  def test_twats_create_record_route
    params = { user_id: current_user.id,
               message: "test_twats_create_record_route" }
    post "/twats", params
    assert last_response.status, be_redirect
  ensure
    Twat.find_by(params)&.destroy
  end

  def test_twats_edit_record_route
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_record_route")
    get "/twats/#{twat.id}/edit"
    assert last_response.ok?, last_response.status
  ensure
    twat&.destroy
  end

  def test_twats_update_record_route
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_preupdate_record_route")
    params = { message: "test_post-update_record_route" }
    put "/twats/#{twat.id}", params
    assert last_response.status, be_redirect
  ensure
    twat&.destroy
  end

  def test_twats_destroy_record_route
    twat = Twat.find_or_create_by(user_id: current_user.id,
                                  message: "test_twats_destroy_record_route")
    delete "/twats/#{twat.id}"
    assert last_response.status, be_redirect
  ensure
    twat&.destroy
  end
end
