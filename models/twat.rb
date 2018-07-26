# frozen_string_literal: true

class Twat < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  has_many :comments
  has_many :likes
  has_many :retwats

  alias_attribute :twatter, :user
  alias_attribute :twatter_id, :user_id

  scope :all_mine, ->(user) { where(user_id: user.id) }
  scope :filtered, ->(user) { where.not(user_id: blocked_user_ids(user.id)) }
  scope :most_recent, -> { order(created_at: :asc) }

  def self.blocked_user_ids(user_id)
    BlockedUser.where(user_id: user_id).pluck(:blocker_id) +
      BlockedUser.where(blocker_id: user_id).pluck(:user_id)
  end
end
