-- CREATE DATABASE twatter;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(300) NOT NULL,
  name VARCHAR(300) NOT NULL,
  email VARCHAR(300) NOT NULL,
  image_url VARCHAR(500),
  password_digest VARCHAR(400) NOT NULL,
  twats_count INTEGER DEFAULT(0),
  followers_count INTEGER DEFAULT(0),
  following_count INTEGER DEFAULT(0),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (id, username, name, email, password_digest) VAlUES (0, 'null_user', 'Null User', 'null_user@sinatra.app', 'impossible-hash');

-- CREATE TABLE user_profiles (
--   id SERIAL4 PRIMARY KEY,
--   user_id INTEGER,
--   name VARCHAR(300) NOT NULL,
--   image_url VARCHAR(400),
--   twats_count INTEGER DEFAULT(0),
--   followers_count INTEGER DEFAULT(0),
--   following_count INTEGER DEFAULT(0),
--   created_at TIMESTAMP DEFAULT NOW(),
--   updated_at TIMESTAMP DEFAULT NOW()
-- );

DROP TABLE IF EXISTS twats;
CREATE TABLE twats (
  id SERIAL4 PRIMARY KEY,
  message TEXT,
  user_id INTEGER,
  comments_count INTEGER DEFAULT(0),
  likes_count INTEGER DEFAULT(0),
  retwats_count INTEGER DEFAULT(0),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Followed Users (their Twats get added to their User timeline)
DROP TABLE IF EXISTS followed_users;
CREATE TABLE followed_users (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  follower_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Blocked Users (for a given User ID, Block ID are Users who are & get unseen)
DROP TABLE IF EXISTS blocked_users;
CREATE TABLE blocked_users (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  blocker_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  twat_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS retwats;
CREATE TABLE retwats (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  twat_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  content TEXT,
  user_id INTEGER,
  twat_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id SERIAL4 PRIMARY KEY,
  content TEXT,
  to_id INTEGER,
  from_id INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
