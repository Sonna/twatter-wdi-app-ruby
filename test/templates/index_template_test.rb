# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../..", __dir__)

require "erb"
require "tilt"

require "test/test_helper"

class IndexTemplateTest < Minitest::Test
  class LocalsStub
    STUBBED_HELPERS = %w[logged_in?].freeze
    STUBBED_LOCALS = %w[
      image_url username twat_id comments_count likes retwats twatter_id message
    ].freeze

    STUBBED_HELPERS.each { |method_name| define_method(method_name) { nil } }
    STUBBED_LOCALS.each { |method_name| define_method(method_name) { nil } }

    def erb(path, *args)
      template = Tilt.new(File.join(ROOT, "templates", "#{path}.erb"))
      template.render(self, *args)
    end
  end

  def test_render_root_index_template
    subject = erb(:index)
    assert_match "Twatter", subject
  end

  def erb(path, *args)
    layout = Tilt.new(File.join(ROOT, "templates", "layouts", "default.erb"))
    template = Tilt.new(File.join(ROOT, "templates", "#{path}.erb"))
    layout.render(LocalsStub.new) { template.render(LocalsStub.new, *args) }
  end
end
