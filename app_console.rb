$LOAD_PATH.push File.expand_path("..", __FILE__)
require "main"

def app_console
  @grace = User.create(email: "grace@email.com", name: "Test grace",
                       username: "testgrace", password: "password")
  @harry = User.create(email: "harry@email.com", name: "Test harry",
                       username: "testharry", password: "password")
  @grace_follows_harry = FollowedUser.create(user_id: @harry.id,
                                             follower_id: @grace.id)

  @grace_follows_harry
  # => #<FollowedUser:0x00007fca2617db38
  #     id: 97,
  #     user_id: 2370,
  #     follower_id: 2369>
  @grace.reload.followers_count # => 0
  @grace.followers
  # => []
  @grace.following_count # => 1
  @grace.following
  # => [#<User:0x00007fca26938990
  #      id: 2370,
  #      username: "testharry",
  #      name: "Test harry",
  #      email: "harry@email.com",
  #      password_digest:
  #       "$2a$10$2K3Sf0RwM1Y0nUCno1jFxuDHRI3GR98hMxN8bERtZ02ImeQYXOlMe",
  #      followers_count: 1,
  #      following_count: 0>]

  @harry.reload.followers_count # => 1
  @harry.followers
  # => [#<User:0x00007fca259233e8
  #      id: 2369,
  #      username: "testgrace",
  #      name: "Test grace",
  #      email: "grace@email.com",
  #      password_digest:
  #       "$2a$10$Lo4drGvEcjCI3lVb/INjce8zfy52mooJ/90GkODroeU8G/7Ic.DD6",
  #      followers_count: 0,
  #      following_count: 1>]
  @harry.following_count # => 0
  @harry.following
  # => []

ensure
  @grace&.destroy
  @harry&.destroy
  @grace_follows_harry&.destroy
end
app_console
