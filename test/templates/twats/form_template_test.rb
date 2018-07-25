# frozen_string_literal: true

require "test/test_helper"

class FormTemplateTest < Minitest::Test
  include TemplateTestTool

  def setup
    @subject = erb(:"twats/form")
  end

  def teardown
    @subject = nil
  end

  def test_render_twat_form_partial_template
    assert_match(
      %r{<form id="twat-form" action="/twats" method="post">(.|\n)*</form>},
      @subject
    )
  end

  def test_twat_form_partial_template_contains_message_field
    assert_match(
      /<input type="text" name="message" placeholder="What's happening\?">/,
      @subject
    )
  end

  def test_twat_form_partial_template_has_a_post_button
    assert_match %r{<button>post</button>}, @subject
  end
end
