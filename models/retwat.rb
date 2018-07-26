# frozen_string_literal: true

class Retwat < ActiveRecord::Base
  belongs_to :user
  belongs_to :twat, counter_cache: true

  def retwated_by
    user.name
  end
end
