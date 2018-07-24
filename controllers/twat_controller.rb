require "controllers/application_controller"
require "models/twat"

class TwatController < ApplicationController
  set(:views, File.join(ROOT, "/templates/twats"))

  get "/twats" do
    @twats = Twat.all
    erb :index
  end

  get "/twats/new" do
    erb :new
  end

  get "/twats/:id" do
    @twat = Twat.find(params[:id])
    erb :show
  end

  post "/twats/twats" do
    @twat = Twat.create(name: params[:name], image_url: params[:image_url])
    redirect to("/#{@twat.id}")
  end

  get "/twats/:id/edit" do
    @twat = Twat.find(params[:id])
    erb :edit
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
