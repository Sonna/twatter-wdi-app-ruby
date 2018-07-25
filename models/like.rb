# frozen_string_literal: true

class Like < ActiveRecord::Base
  belongs_to :twat, counter_cache: true
end
