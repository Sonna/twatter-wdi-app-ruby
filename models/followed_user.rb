# frozen_string_literal: true

class FollowedUser < ActiveRecord::Base
  belongs_to :profile, class_name: "Profile",
                       primary_key: "user_id", foreign_key: "user_id"
  belongs_to :follower, class_name: "Profile",
                        primary_key: "user_id", foreign_key: "follower_id"

  after_create :increase_count
  after_destroy :decrease_count

  private

  def increase_count
    profile&.increment!(:followers_count)
    follower&.increment!(:following_count)
  end

  def decrease_count
    profile&.decrement!(:followers_count)
    follower&.decrement!(:following_count)
  end
end
