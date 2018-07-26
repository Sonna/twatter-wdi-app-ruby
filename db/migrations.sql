-- Migrations

-- Thu 26 Jul 2018 13:56:11 AEST
ALTER TABLE users ADD followers_count INTEGER DEFAULT(0);
ALTER TABLE users ADD following_count INTEGER DEFAULT(0);
