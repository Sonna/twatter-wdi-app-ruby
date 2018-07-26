# frozen_string_literal: true

class NullUser
  def email
    "null_user@sinatra.app"
  end

  def followers
    User.none
  end

  def following
    User.none
  end

  def id
    0
  end

  def image_url
    "/images/avatar2.png"
  end
end
