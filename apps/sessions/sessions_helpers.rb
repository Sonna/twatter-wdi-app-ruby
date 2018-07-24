# frozen_string_literal: true

require "models/null_user"
require "models/user"

module SessionsHelpers
  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  # rubocop:disable Style/DoubleNegation
  def logged_in?
    !!current_user
  end
  # rubocop:enable Style/DoubleNegation

  def authorized?
    redirect to("/") unless logged_in?
    current_user
  end
end
