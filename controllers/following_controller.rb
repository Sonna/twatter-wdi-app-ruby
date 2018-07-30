# frozen_string_literal: true

require "controllers/application_controller"
require "models/followed_user"
require "models/user"

class FollowingController < ApplicationController
  set(:views, File.join(ROOT, "/templates"))

  get "/following/:username" do
    authorized?
    @following = current_user.profile.following
    if params[:username]
      @following = User.find_by(username: params[:username]).following
    end
    erb :"following/index", layout: :"layouts/default", locals: {
      following: @following,
      username: params[:username]
    }
  end
end
