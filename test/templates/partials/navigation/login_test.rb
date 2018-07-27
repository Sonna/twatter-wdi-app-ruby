# frozen_string_literal: true

require "test/test_helper"

class LoginTemplateTest < Minitest::Test
  include TemplateTestTool

  class WhenNotLoggedIn < LoginTemplateTest
    # <a href="/login">login</a>
    def test_login_link_in_navigation
      subject = erb(:"partials/navigation/login")
      assert_match %r{<a href="/login">(.|\n)*</a>}, subject
    end

    # <a href="/users/new">signup</a>
    def test_signup_link_in_navigation
      subject = erb(:"partials/navigation/login")
      assert_match %r{<a href="/users/new">(.|\n)*</a>}, subject
    end
  end

  class WhenLoggedIn < LoginTemplateTest
    # <span class="user">logged in as <%= current_user.email %></span>
    def test_login_username_in_navigation
      subject = erb(:"partials/navigation/login", self)
      assert_match(
        Regexp.new(
          "logged in as(.|\n)*" \
          "<a href=\"/users/logintemplatetest\">@logintemplatetest</a>"
        ),
        subject
      )
    end

    # <form action="/session" method="post">
    #   <input type="hidden" name="_method" value="delete">
    #   <button>logout</button>
    # </form>
    def test_signout_button_in_navigation
      subject = erb(:"partials/navigation/login", self)
      assert_match "logout", subject
    end

    MockUser = Struct.new(:email, :username)
    def current_user
      MockUser.new("LoginTemplateTest", "logintemplatetest")
    end

    def logged_in?
      true
    end
  end
end
