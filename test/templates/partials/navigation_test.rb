# frozen_string_literal: true

require "test/test_helper"

class NavigationTemplateTest < Minitest::Test
  include TemplateTestTool

  def test_render_navigation_partial_template
    subject = erb(:"partials/navigation")
    assert_match %r{<nav id="navbar" class="navigation">(.|\n)*</nav>}, subject
  end
end
