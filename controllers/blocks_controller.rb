# frozen_string_literal: true

require "controllers/application_controller"
require "models/block_user"

class BlocksController < ApplicationController
  post "/blocks" do
    authorized?
    BlockUser.create(user_id: current_user.id, blocked_id: params[:twatter_id])
    redirect to("/")
  end
end
