require "models/null_user"
require "models/user"

module SessionsHelpers
  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  def logged_in?
    !!current_user
  end

  def authorized?
    redirect to("/") unless logged_in?
    current_user
  end
end
