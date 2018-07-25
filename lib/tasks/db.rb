# frozen_string_literal: true

# desc "Explaining what the task does"
# task :xperior_tech_challenge do
#   # Task goes here
# end

require "active_record"
require "yaml"

# == Usage:
# ```shell
#     $ rake db:create
#     $ rake db:schema:load
# ```
namespace :db do
  class DatabaseAlreadyExists < StandardError; end # :nodoc:

  # Stub out Rails `env` method
  module Rails
    def self.env; end
  end

  ROOT_PATH = File.expand_path("../..", __dir__)

  db_config = YAML.load_file(File.join(ROOT_PATH, "config/database.yml"))
  options = ENV["DATABASE_URL"] || db_config["development"]

  # == Usage:
  # ```shell
  #     $ rake db:create
  # ```
  desc "Create the database with default options"
  task :create do
    ActiveRecord::Base.establish_connection(options)
    ActiveRecord::Base.connection.create_database(
      ENV["DATABASE_NAME"] || options["database"]
    )
    puts "Database created."
  rescue ActiveRecord::StatementInvalid => error
    raise DatabaseAlreadyExists if error.cause.is_a?(PG::DuplicateDatabase)
    raise
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(options)
    ActiveRecord::Base.connection.drop_database(
      ENV["DATABASE_NAME"] || options["database"]
    )
    puts "Database deleted."
  end

  desc "Create a db/schema.rb file that is portable DB supported by AR"
  task :schema do
    ActiveRecord::Base.establish_connection(options)
    require "active_record/schema_dumper"
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

  namespace :schema do
    # == Usage:
    # ```shell
    #     $ rake db:schema:load
    # ```
    desc "Load the database schema via the `db/schema.rb` file"
    task :load do
      ActiveRecord::Tasks::DatabaseTasks.load_schema(
        options, :ruby, File.join(ROOT_PATH, "db/schema.rb")
      )
    end

    # == Usage:
    # ```shell
    #     $ rake db:schema:raw_load
    # ```
    desc "Load the database schema via the `db/schema.sql` file"
    task :raw_load do
      ActiveRecord::Base.establish_connection(options)
      ActiveRecord::Base.connection.execute(
        IO.read(File.join(ROOT_PATH, "db/schema.sql"))
      )
    end
  end
end
