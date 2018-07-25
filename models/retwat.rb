# frozen_string_literal: true

class Retwat < ActiveRecord::Base
  belongs_to :twat, counter_cache: true
end
