# frozen_string_literal: true

class Retwat < ActiveRecord::Base
  belongs_to :user
  belongs_to :twat, counter_cache: true

  alias_attribute :retwated_by, :user

  delegate :name, to: :user, allow_nil: true
  delegate :username, to: :user, allow_nil: true
end
