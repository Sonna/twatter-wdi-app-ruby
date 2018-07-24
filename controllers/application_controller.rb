require "sinatra/base"

class ApplicationController < Sinatra::Base
  # helpers ApplicationHelpers

  set :views, File.expand_path(ROOT, "/templates")
  enable :sessions

  not_found { erb :not_found }
end
