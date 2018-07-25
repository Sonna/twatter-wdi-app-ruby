# frozen_string_literal: true

require "active_record"
require "yaml"

options = YAML.load_file(File.join(__dir__, "config/database.yml"))
options = options["development"]

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || options)

# ```shell
#   pg_dump -Fc --no-acl --no-owner -h "::" \
#           -Upostgres -p5433 twatter > latest.dump
#
#   heroku pg:backups:restore \
#     https://github.com/Sonna/project2-wdi/blob/master/latest.dump\?raw\=true \
#     DATABASE_URL --confirm nameless-springs-49405
# ```
