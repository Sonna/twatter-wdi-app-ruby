# frozen_string_literal: true

class BlockedUser < ActiveRecord::Base
  belongs_to :profile, class_name: "Profile",
                       primary_key: "user_id", foreign_key: "user_id"
  belongs_to :blocker, class_name: "Profile",
                       primary_key: "user_id", foreign_key: "blocker_id"
end
