# frozen_string_literal: true

class FollowedUser < ActiveRecord::Base
  belongs_to :user, counter_cache: :followers_count
  belongs_to :follower, class_name: "User", counter_cache: :following_count
end
