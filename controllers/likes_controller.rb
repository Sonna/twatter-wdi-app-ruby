# frozen_string_literal: true

require "controllers/application_controller"
require "models/like"

class LikesController < ApplicationController
  post "/likes" do
    authorized?
    Like.find_or_create_by(user_id: current_user.id, twat_id: params[:twat_id])
    redirect to("/")
  end

  delete "/likes/:id" do
    authorized?
    # Like.find_by(id: params[:id], user_id: current_user.id)&.destroy
    Like.find(params[:id])&.destroy
    redirect to("/")
  end
end
