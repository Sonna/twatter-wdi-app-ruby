# frozen_string_literal: true

ROOT = File.expand_path(__dir__)
$LOAD_PATH.push ROOT

require "db_config"
require "sinatra/base"
require "apps/sessions/sessions_app"
require "controllers/blocked_users_controller"
require "controllers/followed_users_controller"
require "controllers/likes_controller"
require "controllers/twats_controller"
require "controllers/users_controller"
require "models/comment"
require "models/like"
require "models/retwat"

class TwatterApp < Sinatra::Base
  set :root, ROOT

  # middleware will run before filters
  use SessionsApp
  use UsersController
  use TwatsController
  use BlockedUsersController
  use FollowedUsersController
  use LikesController

  helpers SessionsHelpers

  # before { redirect "/login" unless session[:user_id] }

  set :method_override, true
  set(:views, File.join(settings.root, "templates"))

  get("/") do
    @twats = Twat.filtered(current_user).most_recent.limit(10)
    @twats = Twat.default(current_user) if logged_in?
    @twats = @twats.posted_by(params["twatter_id"]) if params["twatter_id"]
    erb :index
  end

  # post("/likes") { redirect "/timeline?twat_id=#{params["twat_id"]}" }

  # post("/retwats") { redirect "/timeline?twat_id=#{retwat.id}" }

  # get("/messages/new") do
  #   erb :"message/new", locals { twatter_id: params["twatter_id"] }
  # end
end
