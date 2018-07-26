# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  # has_many :blocked_users
  # has_many :blocks, through: :blocked_users
  # has_many :inverse_blocked_users, class_name: "BlockedUser",
  #                                  foreign_key: "blocked_id"
  # has_many :inverse_blocks, through: :inverse_blocked_users, source: :user

  has_many :blocked_users
  has_many :blockers, through: :blocked_users
  # has_many :comments
  # has_many :followers
  # has_many :following
  has_many :likes
  # has_many :messages
  # has_many :twats

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

  def image_url
    "/images/avatar3.png"
  end
end
