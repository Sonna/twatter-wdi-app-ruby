require "sinatra/base"

require "apps/sessions/sessions_helpers"
require "models/user"

class SessionsApp < Sinatra::Base
  set(:views, File.join(ROOT, "/templates/sessions"))

  enable :sessions

  helpers SessionsHelpers

  get("/login") { erb :login }

  post "/session" do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      erb :login
    end
  end

  delete "/session" do
    session[:user_id] = nil
    redirect "/login"
  end

  get("/signup") { erb :signup }
  get("/users/new") { erb :signup }

  post "/users" do
    user = User.new(email: params[:email], password: params[:password])
    redirect "/" if user.valid? && user.save
    erb :signup
  end
end