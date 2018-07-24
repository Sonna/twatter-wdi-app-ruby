CREATE DATABASE twatter;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300) NOT NULL,
  password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE twats (
  id SERIAL4 PRIMARY KEY,
  message TEXT,
  user_id INTEGER,
  created_at DATE,
  updateed_at DATE
);

-- Followed Users (their Twats get added to their User timeline)
CREATE TABLE followers (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  follower_id INTEGER
);

-- Blocked Users (for a given User ID, Block ID are Users who are & get unseen)
CREATE TABLE blocks (
  user_id INTEGER,
  block_id INTEGER
);
