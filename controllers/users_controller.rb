# frozen_string_literal: true

require "controllers/application_controller"
require "models/user"

class UsersController < ApplicationController
  set(:views, File.join(ROOT, "/templates"))

  get("/users/:username") do
    @twatter = User.find_by(username: params[:username])
    @twats = Twat.filtered(current_user)
                 .most_recent
                 .posted_by(@twatter.id)
                 .limit(10)
    erb :"users/show"
  end
end
