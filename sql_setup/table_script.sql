USE empty_galaxy;

CREATE TABLE IF NOT EXISTS user (
userid int AUTO_INCREMENT PRIMARY KEY,
email varchar(255),
hashedpassword varchar(255),
sessionid varchar(255)
);

CREATE TABLE IF NOT EXISTS ship (
shipid int,
userid int,
model varchar(255),
direction varchar(8),
position int,
energy int,
armor int,
shield int
);

CREATE TABLE IF NOT EXISTS turret (
turretid int,
shipid int,
model varchar(255),
energy int
);
