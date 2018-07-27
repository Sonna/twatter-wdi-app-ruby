# frozen_string_literal: true

require "controllers/application_controller"
require "models/retwat"

class RetwatsController < ApplicationController
  post "/retwats" do
    authorized?
    Retwat.create(user_id: current_user.id, twat_id: params[:twat_id])
    redirect to("/")
  end

  delete "/retwats/:id" do
    authorized?
    Retwat.find_by(id: params[:id], user_id: current_user.id)&.destroy
    redirect to("/")
  end
end
