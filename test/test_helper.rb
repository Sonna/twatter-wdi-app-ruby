# frozen_string_literal: true

ROOT_PATH = File.expand_path("..", __dir__)
$LOAD_PATH.push ROOT_PATH

require "minitest/autorun"
require "rack/test"

require "main"

Dir[File.join(ROOT_PATH, "test", "support", "*.rb")].each { |f| require f }
