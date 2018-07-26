# frozen_string_literal: true

require "controllers/application_controller"
require "models/blocked_user"

class BlockedUsersController < ApplicationController
  post "/blocks" do
    authorized?
    BlockedUser.create(user_id: current_user.id,
                       blocker_id: params[:blocker_id])
    redirect to("/")
  end

  delete "/blocks/:id" do
    authorized?
    BlockedUser.find_by(id: params[:id], user_id: current_user.id)&.destroy
    redirect to("/")
  end
end
