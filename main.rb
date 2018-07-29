# frozen_string_literal: true

ROOT = File.expand_path(__dir__)
$LOAD_PATH.push ROOT

require "db_config"
require "sinatra/base"
require "apps/sessions/sessions_app"
require "controllers/blocked_users_controller"
require "controllers/comments_controller"
require "controllers/followed_users_controller"
require "controllers/following_controller"
require "controllers/followers_controller"
require "controllers/likes_controller"
require "controllers/retwats_controller"
require "controllers/twats_controller"
require "controllers/users_controller"
require "models/comment"
require "models/like"
require "models/message"
require "models/retwat"

class TwatterApp < Sinatra::Base
  set :root, ROOT

  # middleware will run before filters
  use SessionsApp
  use UsersController
  use TwatsController
  use BlockedUsersController
  use CommentsController
  use FollowersController
  use FollowingController
  use FollowedUsersController
  use LikesController
  use RetwatsController

  helpers SessionsHelpers

  set :method_override, true
  set(:views, File.join(settings.root, "templates"))

  get("/") do
    @twats = Twat.filtered(current_user).most_recent.limit(10)
    @twats = Twat.default(current_user) if logged_in?
    erb :index
  end
end
