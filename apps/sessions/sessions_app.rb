# frozen_string_literal: true

require "active_record"
require "sinatra/base"

require "apps/sessions/sessions_helpers"
require "models/user"

class SessionsApp < Sinatra::Base
  set :root, File.expand_path("../..", __dir__)
  set(:views, File.join(settings.root, "/templates/sessions"))

  enable :sessions

  helpers SessionsHelpers

  get("/login") { erb :login, layout: :authenticate }

  post "/session" do
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      erb :login, layout: :authenticate
    end
  end

  delete "/session" do
    session[:user_id] = nil
    redirect "/"
  end

  get("/signup") { erb :signup, layout: :authenticate }
  get("/users/new") { erb :signup, layout: :authenticate }

  post "/users" do
    user = User.new(email: params[:email], password: params[:password],
                    username: params[:username], name: params[:name])
    if user.valid? && user.save
      session[:user_id] = user.id
      redirect "/"
    end
    erb :signup, layout: :authenticate
  end
end
