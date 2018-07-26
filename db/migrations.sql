-- Migrations

-- Thu 26 Jul 2018 13:56:11 AEST
ALTER TABLE users ADD followers_count INTEGER DEFAULT(0);
ALTER TABLE users ADD following_count INTEGER DEFAULT(0);

-- Thu 26 Jul 2018 14:24:04 AEST
ALTER TABLE users ADD twats_count INTEGER DEFAULT(0);
