class User < ActiveRecord::Base
  has_secure_password

  # has_many :block_users
  # has_many :comments
  # has_many :followers
  # has_many :following
  # has_many :messages
  # has_many :twats

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
