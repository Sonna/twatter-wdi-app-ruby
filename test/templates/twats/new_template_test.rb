# frozen_string_literal: true

require "test/templates/twats/form_template_test"

class NewTemplateTest < FormTemplateTest
  def setup
    @subject = erb(:"twats/new")
  end
end
