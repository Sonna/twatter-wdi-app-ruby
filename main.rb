ROOT = File.expand_path("../", __FILE__)
$LOAD_PATH.push ROOT

require "db_config"
require "sinatra/base"

class TwatterApp < Sinatra::Base
  set(:views, File.join(ROOT, "/templates"))

  get("/") { erb :index }
end
