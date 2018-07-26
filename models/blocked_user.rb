# frozen_string_literal: true

class BlockedUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :blocked, class_name: "User"
end
