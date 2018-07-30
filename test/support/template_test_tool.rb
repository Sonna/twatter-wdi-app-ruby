# frozen_string_literal: true

require "erb"
require "tilt"

module TemplateTestTool
  class LocalsStub
    attr_reader :attributes

    STUBBED_HELPERS = %w[logged_in?].freeze
    STUBBED_LOCALS = %w[
      id twat_id comments_count likes retwats twatter_id message user_id
    ].freeze

    def self.create_method
      ->(method_name) { define_method(method_name) { nil } }
    end

    STUBBED_HELPERS.each(&create_method)
    STUBBED_LOCALS.each(&create_method)

    def initialize(**hash)
      @path_info = "/"
      # args.each instance_variable_set(name, value)
      hash.each(&method(:instance_variable_set))
      @attributes = hash
    end

    LocalUser = Struct.new(:id, :image_url, :name, :username)
    def current_user
      LocalUser.new(nil, nil, nil, nil)
    end

    def erb(path, *args)
      template = Tilt.new(File.join(ROOT, "templates", "#{path}.erb"))
      template.render(self, *args)
    end

    def method_missing(method_name, *args, &block)
      attributes.fetch("@#{method_name}".to_sym, nil) || super
    end

    def respond_to_missing?(method_name, include_private = false)
      attributes.key?("@#{method_name}".to_sym) || super
    end

    LocalRequest = Struct.new(:path_info)
    def request
      LocalRequest.new(@path_info)
    end
  end

  def erb(path, self_class = LocalsStub.new, *args)
    layout = Tilt.new(File.join(ROOT, "templates", "layouts", "default.erb"))
    template = Tilt.new(File.join(ROOT, "templates", "#{path}.erb"))
    layout.render(LocalsStub.new) { template.render(self_class, *args) }
  end
end
