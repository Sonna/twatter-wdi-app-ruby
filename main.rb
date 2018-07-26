# frozen_string_literal: true

ROOT = File.expand_path(__dir__)
$LOAD_PATH.push ROOT

require "db_config"
require "sinatra/base"
require "apps/sessions/sessions_app"
require "controllers/twats_controller"
require "controllers/followed_users_controller"
require "controllers/blocked_users_controller"
require "models/comment"
require "models/like"
require "models/retwat"

class TwatterApp < Sinatra::Base
  set :root, ROOT

  # middleware will run before filters
  use SessionsApp
  use TwatsController
  use BlockedUsersController

  helpers SessionsHelpers

  # before { redirect "/login" unless session[:user_id] }

  set(:views, File.join(settings.root, "templates"))

  get("/") do
    @twats = Twat.filtered(current_user).most_recent.limit(10)
    @twats = @twats.posted_by(params["twatter_id"]) if params["twatter_id"]
    erb :index
  end
  # map("/twats") { run TwatController }

  # UsersController#show
  get("/users/:username") do
    user = User.find_by(username: params[:username])
    @twats = Twat.filtered(current_user)
                 .most_recent
                 .posted_by(user.id)
                 .limit(10)
    erb :index
  end

  # post("/likes") { redirect "/timeline?twat_id=#{params["twat_id"]}" }

  # post("/retwats") { redirect "/timeline?twat_id=#{retwat.id}" }

  # get("/messages/new") do
  #   erb :"message/new", locals { twatter_id: params["twatter_id"] }
  # end
end
