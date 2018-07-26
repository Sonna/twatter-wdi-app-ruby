# frozen_string_literal: true

class FollowedUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, class_name: "User"
end
