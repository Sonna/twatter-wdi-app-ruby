require "controllers/application_controller"
require "models/twat"

class TwatController < ApplicationController
  # set :views, File.expand_path(ROOT, "templates/twats")

  get "/twats" do
    @twats = Twat.all
    erb :"templates/twats/index"
  end

  get "/twats/new" do
    erb :"templates/twats/new"
  end

  get "/twats/:id" do
    @twat = Twat.find(params[:id])
    erb :"templates/twats/show"
  end

  post "/twats/twats" do
    @twat = Twat.create(name: params[:name], image_url: params[:image_url])
    redirect to("/#{@twat.id}")
  end

  get "/twats/:id/edit" do
    @twat = Twat.find(params[:id])
    erb :"templates/twats/edit"
  end

  put "/twats/:id" do
    @twat = Twat.find(params[:id])
    @twat&.update(params) # NOT SECURE!
    redirect to("/#{@twat.id}")
  end

  delete "/twats/:id" do
    Twat.destroy(params[:id])
    redirect to("/")
  end

  # post("/twats/:id/like") {}
end
