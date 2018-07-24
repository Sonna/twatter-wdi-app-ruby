require "active_record"

options = {
  adapter: "postgresql",
  database: "twatter",
  username: "postgres",
  hostaddr: "::",
  port: 5433
}

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || options)

# ```shell
#   pg_dump -Fc --no-acl --no-owner -h "::" -Upostgres -p5433 goodfoodhunting > latest.dump
#   heroku pg:backups:restore https://github.com/Sonna/orm_goodfoodhunting-heroku_deploy-wdi/blob/master/latest.dump\?raw\=true DATABASE_URL --confirm nameless-springs-49405
# ```
