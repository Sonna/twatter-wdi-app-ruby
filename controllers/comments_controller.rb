# frozen_string_literal: true

require "controllers/application_controller"
require "models/comment"

class CommentsController < ApplicationController
  post "/comments" do
    authorized?
    @comment = Comment.create(
      content: params[:content],
      twat_id: params[:twat_id],
      user_id: current_user.id
    )
    redirect to("/twats/#{params[:twat_id]}")
  end
end
