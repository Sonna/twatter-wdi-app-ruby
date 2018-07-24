CREATE DATABASE twatter;

-- DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(300) NOT NULL,
  name VARCHAR(300) NOT NULL,
  email VARCHAR(300) NOT NULL,
  password_digest VARCHAR(400) NOT NULL
);

INSERT INTO users (id, username, name, email, password_digest) VAlUES (0, 'null_user', 'Null User', 'null_user@sinatra.app', 'impossible-hash');

-- CREATE TABLE user_profiles (
--   id SERIAL4 PRIMARY KEY,
--   user_id INTEGER,
--   name VARCHAR(300) NOT NULL,
--   image_url VARCHAR(400)
-- );

-- DROP TABLE IF EXISTS twats;
CREATE TABLE twats (
  id SERIAL4 PRIMARY KEY,
  message TEXT,
  user_id INTEGER,
  created_at DATE,
  updated_at DATE
);

-- Followed Users (their Twats get added to their User timeline)
CREATE TABLE followers (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  follower_id INTEGER
);

-- Blocked Users (for a given User ID, Block ID are Users who are & get unseen)
CREATE TABLE block_users (
  user_id INTEGER,
  block_id INTEGER
);

CREATE TABLE likes (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  twat_id INTEGER
);

CREATE TABLE retwats (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  twat_id INTEGER
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  content TEXT,
  user_id INTEGER,
  twat_id INTEGER
);
