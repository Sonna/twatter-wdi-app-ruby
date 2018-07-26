# frozen_string_literal: true

require "controllers/application_controller"
require "models/followed_user"

class FollowedUsersController < ApplicationController
  post "/follows" do
    authorized?
    FollowedUser.create(follower_id: current_user.id,
                        user_id: params[:follower_id])
    redirect to("/")
  end

  delete "/follows/:user_id" do
    authorized?
    FollowedUser.find_by(user_id: params[:user_id],
                         follower_id: current_user.id)&.destroy
    redirect to("/")
  end
end
