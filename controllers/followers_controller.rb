# frozen_string_literal: true

require "controllers/application_controller"
require "models/followed_user"
require "models/user"

class FollowersController < ApplicationController
  set(:views, File.join(ROOT, "/templates"))

  get "/followers/:username" do
    authorized?
    @followers = current_user.followers
    if params[:username]
      @followers = User.find_by(username: params[:username]).followers
    end
    erb :"followers/index", layout: :"layouts/default", locals: {
      followers: @followers,
      username: params[:username]
    }
  end
end
