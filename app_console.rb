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
  # => #<FollowedUser:0x00007f8fcb9a97e8
  #     id: 29,
  #     user_id: 1867,
  #     follower_id: 1866>
  @grace.followers
  # => []
  @grace.following
  # => [#<User:0x00007f8fce2a2898
  #      id: 1867,
  #      username: "testharry",
  #      name: "Test harry",
  #      email: "harry@email.com",
  #      password_digest:
  #       "$2a$10$GUj30NvELSXsm1oNCU0ngemHY/Ce3iKWkkC7HlehVYF4/cYo/sDgq">]

  @harry.followers
  # => [#<User:0x00007f8fce278728
  #      id: 1866,
  #      username: "testgrace",
  #      name: "Test grace",
  #      email: "grace@email.com",
  #      password_digest:
  #       "$2a$10$XaJURT5pHOT0qXnhyTmos.7A46pH36lABRizdrj/3kWZUhiXaXm4i">]
  @harry.following
  # => []

ensure
  @grace&.destroy
  @harry&.destroy
  @grace_follows_harry&.destroy
end
app_console
