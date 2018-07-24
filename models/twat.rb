class Twat < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :likes
  has_many :retwats

  alias_attribute :twatter, :user
end
