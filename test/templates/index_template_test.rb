# frozen_string_literal: true

require "test/test_helper"

class IndexTemplateTest < Minitest::Test
  include TemplateTestTool

  def test_render_root_index_template
    subject = erb(:index, LocalsStub.new(:@twats => []))
    assert_match "Twatter", subject
  end
end
