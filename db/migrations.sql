-- Migrations

-- Thu 26 Jul 2018 13:56:11 AEST
ALTER TABLE users ADD followers_count INTEGER DEFAULT(0);
ALTER TABLE users ADD following_count INTEGER DEFAULT(0);

-- Thu 26 Jul 2018 14:24:04 AEST
ALTER TABLE users ADD twats_count INTEGER DEFAULT(0);

-- Fri 27 Jul 2018 14:28:02 AEST
ALTER TABLE users ADD image_url VARCHAR(500);

-- Sun 29 Jul 2018 21:11:01 AEST
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  image_url VARCHAR(400),
  twats_count INTEGER DEFAULT(0),
  followers_count INTEGER DEFAULT(0),
  following_count INTEGER DEFAULT(0),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- UPDATE users, profiles
-- UPDATE profiles
--   FROM users
--    SET profiles.image_url = users.image_url,
--        profiles.followers_count = users.followers_count,
--        profiles.following_count = users.following_count,
--        profiles.twats_count = users.twats_count
--  WHERE users.id = profiles.user_id;

-- INSERT INTO profiles (image_url, followers_count, following_count, twats_count)
--      SELECT users.image_url, users.followers_count, users.following_count, users.twats_count
--        FROM users, profiles
--       WHERE users.id = profiles.user_id;

INSERT INTO profiles (user_id, image_url, followers_count, following_count, twats_count)
     SELECT users.id, users.image_url, users.followers_count, users.following_count, users.twats_count
       FROM users;

ALTER TABLE users DROP image_url;
ALTER TABLE users DROP followers_count;
ALTER TABLE users DROP following_count;
ALTER TABLE users DROP twats_count;
