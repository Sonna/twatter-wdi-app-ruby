# frozen_string_literal: true

require "date"

require "controllers/application_controller"
require "models/twat"

class TwatController < ApplicationController
  set(:views, File.join(ROOT, "/templates"))

  get "/twats" do
    authorized?
    @twats = Twat.all_mine(current_user)
    erb :"twats/index", layout: :"layouts/default"
  end

  get "/twats/new" do
    authorized?
    erb :"twats/new", layout: :"layouts/default"
  end

  get "/twats/:id" do
    authorized?
    @twat = Twat.find(params[:id])
    erb :"twats/show", layout: :"layouts/default"
  end

  post "/twats" do
    authorized?
    @twat = Twat.create(
      message: params[:message],
      user_id: current_user.id,
      created_at: Date.today,
      updated_at: Date.today
    )
    redirect to("/twats/#{@twat.id}")
  end

  get "/twats/:id/edit" do
    authorized?
    @twat = Twat.find(params[:id])
    erb :"twats/edit", layout: :"layouts/default"
  end

  put "/twats/:id" do
    authorized?
    @twat = Twat.find(params[:id])
    @twat&.update(message: params[:message], updated_at: Date.today)
    redirect to("/twats/#{@twat.id}")
  end

  delete "/twats/:id" do
    authorized? # does not check User association
    Twat.destroy(params[:id])
    redirect to("/")
  end

  # post("/twats/:id/like") {}
end
