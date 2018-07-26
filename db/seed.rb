# frozen_string_literal: true

# Seed database file

$LOAD_PATH.push File.expand_path("..", __dir__)
require "main"

User.create(email: "dt@ga.co", username: "dt", name: "DT", password: "pudding")
User.create(email: "kasun@ga.co", username: "kasun", name: "Kasun", password: "not pudding")
User.create(email: "iframes@example.com", username: "iframes", name: "iFrames", password: "shhh....")

Twat.create(message: "LOVES PUDDING!", user_id: User.find_by(username: "dt").id)
Twat.create(message: "Maybe likes pudding.", user_id: User.find_by(username: "kasun").id)

Twat.create(message: "DO", user_id: User.find_by(username: "iframes").id)
Twat.create(message: "NOT", user_id: User.find_by(username: "iframes").id)
Twat.create(message: "USE", user_id: User.find_by(username: "iframes").id)
Twat.create(message: "THE ELEMENT THAT SHALL NOT BE NAMED", user_id: User.find_by(username: "iframes").id)

BlockedUser.create(user_id: User.find_by(username: "dt").id, blocker_id: User.find_by(username: "iframes").id)

Like.create(user_id: User.find_by(username: "kasun").id, twat_id: Twat.find_by(message: "LOVES PUDDING!").id)
