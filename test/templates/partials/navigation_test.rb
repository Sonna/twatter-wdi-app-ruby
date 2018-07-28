# frozen_string_literal: true

require "test/test_helper"

class NavigationTemplateTest < Minitest::Test
  include TemplateTestTool

  def test_render_navigation_partial_template
    subject = erb(:"partials/navigation")
    assert_match %r{<nav id="navbar" class="navigation.*">(.|\n)*</nav>},
                 subject
  end

  def test_navigation_bar_sets_home_link_as_active_on_homepage
    subject = erb(:"partials/navigation", LocalsStub.new(:@path_info => "/"))
    assert_match %r{<a href="/" class="active">Home</a>}, subject
  end

  def test_navigation_bar_sets_twats_link_as_active_on_twats_page
    subject = erb(:"partials/navigation",
                  LocalsStub.new(:@path_info => "/twats"))
    assert_match %r{<a href="/twats" class="active">Twats</a>}, subject
  end
end
