# frozen_string_literal: true

# disable :run

require "capybara"
require "capybara/dsl"
require "capybara/minitest"
# require "rack/test"

Capybara.app = TwatterApp

# module FeatureHelpers
class CapybaraTestCase < Minitest::Test
  # include Rack::Test::Methods
  # include Capybara
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  MockUser = Struct.new(:email, :name, :username, :password) do
    def attributes
      to_h
    end
  end

  # def app
  #   TwatterApp
  # end

  def signup(user)
    visit "/signup"
    fill_in "email", with: user.email
    fill_in "name", with: user.name
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_on "sign up"
  end

  def login(email, password)
    visit "/login"
    # within("#sign-in") do
    fill_in "email", with: email
    fill_in "password", with: password
    click_on "login"
    # end
  end

  def selector(string)
    find(:css, string)
  end
end
