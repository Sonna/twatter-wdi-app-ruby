# frozen_string_literal: true

require "bundler"
# require "bundler/gem_tasks"
$LOAD_PATH.push File.expand_path(__dir__)

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require "rake/testtask"
require "rubocop/rake_task"

require "lib/tasks/db"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop test]
