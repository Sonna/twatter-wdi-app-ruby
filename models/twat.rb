# frozen_string_literal: true

class Twat < ActiveRecord::Base
  MAX_CHARS = 280

  after_create :increase_count
  after_destroy :decrease_count

  belongs_to :profile, primary_key: "user_id", foreign_key: "user_id",
                       class_name: "Profile"

  has_many :comments
  has_many :likes
  has_many :retwats

  alias_attribute :twatter, :profile
  alias_attribute :twatter_id, :user_id

  delegate :image_url, to: :profile, allow_nil: true

  scope :default, lambda { |user|
    filtered(user).following(user).or(filtered(user).retwats(user)).most_recent
                  .distinct.limit(10)
  }

  scope :following, ->(user) { where(user_id: followed_user_ids(user)) }
  scope :filtered, ->(user) { where.not(user_id: blocked_user_ids(user.id)) }
  scope :most_recent, -> { order(created_at: :desc) }
  scope :posted_by, ->(user_id) { where(user_id: user_id) }
  scope :retwats, ->(user) { where(id: retwat_ids(user)) }

  def self.blocked_user_ids(user_id)
    BlockedUser.where(user_id: user_id).pluck(:blocker_id) +
      BlockedUser.where(blocker_id: user_id).pluck(:user_id)
  end

  def self.followed_user_ids(user)
    [user.id] + user.following.pluck(:user_id)
  end

  def self.retwat_ids(user)
    Retwat.where(user_id: followed_user_ids(user)).pluck(:twat_id)
  end

  def like(user_id)
    likes.find_by(user_id: user_id)
  end

  def retwat(user_id)
    retwats.find_by(user_id: user_id)
  end

  # rubocop:disable Metrics/AbcSize
  def retwat?(user)
    !user.id.zero? && twatter_id != user.id &&
      !user.following.pluck(:user_id).include?(twatter_id) &&
      Retwat.where(user_id: user.following.pluck(:user_id), twat_id: id).first
  end
  # rubocop:enable Metrics/AbcSize

  private

  def increase_count
    profile&.increment!(:twats_count)
  end

  def decrease_count
    profile&.decrement!(:twats_count)
  end
end
