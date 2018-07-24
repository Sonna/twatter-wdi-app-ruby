ROOT = File.expand_path("../", __FILE__)
$LOAD_PATH.push ROOT

require "db_config"
require "sinatra/base"

# require "models/user"
#
# enable :sessions
#
# helpers do
#   def current_user
#     User.find_by(id: session[:user_id])
#   end
#
#   def logged_in?
#     !!current_user
#   end
# end

class TwatterApp < Sinatra::Base
  set(:views, File.join(ROOT, "/templates"))

  get("/") { erb :index }

  # get("/login") { erb :login }
  # get("/signup") { erb :signup }
  # post("/session") { redirect "/" }
  # delete("/session") { redirect "/" }
  # post("/users") { redirect "/users/#{user.id}" }
  # get("/users/:user") { erb :user }

  # post("/likes") { redirect "/timeline?twat_id=#{params["twat_id"]}" }

  # post("/retwats") { redirect "/timeline?twat_id=#{retwat.id}" }

  # get("/messages/new") do
  #   erb :"message/new", locals { twatter_id: params["twatter_id"] }
  # end
end
