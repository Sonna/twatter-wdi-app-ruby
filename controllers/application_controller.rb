# frozen_string_literal: true

require "sinatra/base"

require "apps/sessions/sessions_helpers"

class ApplicationController < Sinatra::Base
  # helpers ApplicationHelpers
  helpers SessionsHelpers

  set :method_override, true
  set :views, File.expand_path(ROOT, "/templates")
  enable :sessions

  not_found { erb :not_found }
end
