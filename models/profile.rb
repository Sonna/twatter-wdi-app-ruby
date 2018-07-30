# frozen_string_literal: true

require "models/blocked_user"
require "models/followed_user"

class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :blocked_users, primary_key: "user_id", foreign_key: "user_id",
                           class_name: "BlockedUser"
  has_many :blockers, through: :blocked_users
  has_many :inverse_blocked_users, primary_key: "user_id",
                                   foreign_key: "blocker_id",
                                   class_name: "BlockedUser"
  has_many :inverse_blockers, through: :inverse_blocked_users, source: :profile
  # has_many :comments

  has_many :followed_users, primary_key: "user_id", foreign_key: "user_id",
                            class_name: "FollowedUser"
  has_many :followers, through: :followed_users
  #                    primary_key: "user_id", foreign_key: "user_id"
  # has_many :followers, through: :followed_users, class_name: "FollowedUser",
  #                      primary_key: "user_id", foreign_key: "user_id"
  has_many :inverse_followed_users, primary_key: "user_id",
                                    foreign_key: "follower_id",
                                    class_name: "FollowedUser"
  # has_many :inverse_followers, through: :inverse_followed_users,
  #                              source: :profile
  has_many :inverse_followers, through: :inverse_followed_users,
                               source: :profile
  #                              primary_key: "user_id",
  #                              foreign_key: "follower_id",

  alias_attribute :blocking, :inverse_blockers
  alias_attribute :following, :inverse_followers

  delegate :name, to: :user, allow_nil: true
  delegate :username, to: :user, allow_nil: true

  def attributes
    super.merge("name" => name, "username" => username)
  end

  def image_url
    attributes["image_url"] || "/images/avatar3.png"
  end
end
