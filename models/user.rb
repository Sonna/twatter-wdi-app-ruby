# frozen_string_literal: true

require "models/profile"

class User < ActiveRecord::Base
  has_secure_password

  before_destroy :destroy_profile
  after_create :create_profile

  has_one :profile

  has_many :likes
  # has_many :messages
  # has_many :twats

  delegate :blocking, to: :profile
  delegate :blockers, to: :profile
  delegate :followers, to: :profile
  delegate :following, to: :profile

  delegate :image_url, to: :profile
  delegate :followers_count, to: :profile
  delegate :following_count, to: :profile
  delegate :twats_count, to: :profile

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

  def attributes
    super.merge(
      "image_url" => image_url,
      "followers_count" => followers_count,
      "following_count" => following_count,
      "twats_count" => twats_count
    )
  end

  private

  def create_profile
    Profile.create(user_id: id)
  end

  def destroy_profile
    # Profile.find_by(user_id: id).destroy
    profile&.destroy
  end
end
