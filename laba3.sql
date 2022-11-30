CREATE SCHEMA IF NOT EXISTS Kucher;
USE Kucher ;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS coridor;
DROP TABLE IF EXISTS zone;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS sensor;
DROP TABLE IF EXISTS object;
DROP TABLE IF EXISTS object_has_user;
DROP TABLE IF EXISTS room_has_sensor;
DROP TABLE IF EXISTS coridor_has_sensor;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE coridor (
  idcoridor INT NOT NULL PRIMARY KEY,
`usage` VARCHAR(50) NULL
)
ENGINE = InnoDB;



CREATE TABLE zone (
  idzone INT NOT NULL,
  lvl INT NULL,
  coridor_idcoridor INT NOT NULL,
  PRIMARY KEY (idzone),
  CONSTRAINT fk_zone_coridor1
    FOREIGN KEY (coridor_idcoridor)
    REFERENCES coridor (idcoridor)
    )
ENGINE = InnoDB;



CREATE TABLE user (
  iduser INT UNSIGNED NOT NULL,
  lvl INT NOT NULL,
  name VARCHAR(10) NOT NULL,
  sirname VARCHAR(10) NOT NULL,
  age INT NOT NULL,
  email VARCHAR(319) NOT NULL,
  PRIMARY KEY (iduser))
ENGINE = InnoDB;


CREATE TABLE room (
  idroom INT NOT NULL,
  `usage` VARCHAR(45) NULL,
  zone_idzone INT NOT NULL,
  PRIMARY KEY (idroom, zone_idzone),
  INDEX fk_room_zone1_idx (zone_idzone ASC) VISIBLE,
  CONSTRAINT fk_room_zone1
    FOREIGN KEY (zone_idzone)
    REFERENCES zone (idzone))
ENGINE = InnoDB;


CREATE TABLE sensor (
  idsensor INT NOT NULL,
  class VARCHAR(45) NOT NULL,
  info LONGTEXT NOT NULL,
  alertInfo LONGTEXT NOT NULL,
  alertSettings LONGTEXT NOT NULL,
  PRIMARY KEY (idsensor))
ENGINE = InnoDB;


CREATE TABLE object (
  idobject INT NOT NULL,
  name VARCHAR(100) NULL,
  adress VARCHAR(100) NOT NULL,
  room_idroom INT NOT NULL,
  room_zone_idzone INT NOT NULL,
  coridor_idcoridor INT NOT NULL,
  sensor_idsensor INT NOT NULL,
  PRIMARY KEY (idobject, room_idroom, room_zone_idzone, coridor_idcoridor, sensor_idsensor),
  INDEX fk_object_room1_idx (room_idroom ASC, room_zone_idzone ASC) VISIBLE,
  INDEX fk_object_coridor1_idx (coridor_idcoridor ASC) VISIBLE,
  INDEX fk_object_sensor1_idx (sensor_idsensor ASC) VISIBLE,
  CONSTRAINT fk_object_room1
    FOREIGN KEY (room_idroom , room_zone_idzone)
    REFERENCES room (idroom , zone_idzone),
  CONSTRAINT fk_object_coridor1
    FOREIGN KEY (coridor_idcoridor)
    REFERENCES coridor (idcoridor),
  CONSTRAINT fk_object_sensor1
    FOREIGN KEY (sensor_idsensor)
    REFERENCES sensor (idsensor))
ENGINE = InnoDB;


CREATE TABLE object_has_user (
  object_idobject INT NOT NULL,
  user_iduser INT UNSIGNED NOT NULL,
  PRIMARY KEY (object_idobject, user_iduser),
  INDEX fk_object_has_user_user1_idx (user_iduser ASC) VISIBLE,
  INDEX fk_object_has_user_object1_idx (object_idobject ASC) VISIBLE,
  CONSTRAINT fk_object_has_user_object1
    FOREIGN KEY (object_idobject)
    REFERENCES object (idobject)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_object_has_user_user1
    FOREIGN KEY (user_iduser)
    REFERENCES user (iduser))
ENGINE = InnoDB;



CREATE TABLE room_has_sensor (
  room_idroom INT NOT NULL,
  sensor_idsensor INT NOT NULL,
  PRIMARY KEY (room_idroom, sensor_idsensor),
  INDEX fk_room_has_sensor_sensor1_idx (sensor_idsensor ASC) VISIBLE,
  INDEX fk_room_has_sensor_room1_idx (room_idroom ASC) VISIBLE,
  CONSTRAINT fk_room_has_sensor_room1
    FOREIGN KEY (room_idroom)
    REFERENCES room (idroom)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_room_has_sensor_sensor1
    FOREIGN KEY (sensor_idsensor)
    REFERENCES sensor (idsensor))
ENGINE = InnoDB;



CREATE TABLE coridor_has_sensor (
  coridor_idcoridor INT NOT NULL,
  sensor_idsensor INT NOT NULL,
  PRIMARY KEY (coridor_idcoridor, sensor_idsensor),
  INDEX fk_coridor_has_sensor_sensor1_idx (sensor_idsensor ASC) VISIBLE,
  INDEX fk_coridor_has_sensor_coridor1_idx (coridor_idcoridor ASC) VISIBLE,
  CONSTRAINT fk_coridor_has_sensor_coridor1
    FOREIGN KEY (coridor_idcoridor)
    REFERENCES coridor (idcoridor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_coridor_has_sensor_sensor1
    FOREIGN KEY (sensor_idsensor)
    REFERENCES sensor (idsensor))
ENGINE = InnoDB;


insert into coridor (idcoridor, `usage`) values
(1, "entry"),
(2, "premium"),
(3, "rooms"),
(4, "mid"),
(5, "user"),
(6, "office"),
(7, "personnel");

insert into zone (idzone, lvl, coridor_idcoridor) values
(1, "2", 1),
(2, "1", 2),
(3, "3", 3),
(4, "2", 4),
(5, "1", 5),
(6, "1", 6),
(7, "1", 7);

insert into user (iduser, lvl, name, sirname, age, email) values
(1, 2, "Andriy", "Df", 21, "aa"),
(2, 1, "Jack", "ADS", 24, "ss"),
(3, 3, "Kuku", "DSB", 17, "dd"),
(4, 2, "Ball", "JFC", 15, "vv"),
(5, 1, "Bob", "ABF", 12, "bb"),
(6, 1, "Seki", "SGF", 19, "nn"),
(7, 1, "Asta", "EWQ", 21, "jj");


insert into room (idroom, `usage`, zone_idzone) values
(1, "2", 1),
(2, "1", 2),
(3, "3", 3),
(4, "2", 4),
(5, "1", 5),
(6, "1", 6),
(7, "1", 7);

insert into sensor (idsensor, class, info, alertInfo, alertSettings) values
(1, "S", "Som", "d", "asd"),
(2, "D", "asd", "sadf", "asd"),
(3, "F", "Fasdf", "asdf", "fsd"),
(4, "G", "gfad", "dasf", "vxc"),
(5, "B", "adfg", "fas", "sdf"),
(6, "N", "tre", "fads", "dgf"),
(7, "A", "wetf", "asdf", "sdfg");

insert into object (idobject, name, adress, room_idroom, room_zone_idzone, coridor_idcoridor, sensor_idsensor) values
(1, "S", "asd", 1, 1, 1, 1),
(2, "D", "gfad", 2, 2, 2, 2),
(3, "F", "gfad", 3, 3, 3, 3),
(4, "G", "gfad", 4, 4, 4, 4),
(5, "B", "gfad", 5, 5, 5, 5),
(6, "N", "gfad", 6, 6, 6, 6),
(7, "A", "gfad", 7, 7, 7, 7);


insert into object_has_user (object_idobject, user_iduser) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

insert into room_has_sensor (room_idroom, sensor_idsensor) values  
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

insert into coridor_has_sensor (coridor_idcoridor, sensor_idsensor) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);


SHOW INDEX FROM coridor_has_sensor;
SHOW INDEX FROM room_has_sensor;
