DROP SEQUENCE city_seq;
DROP SEQUENCE program_seq;

DROP TRIGGER Order_Friend_Pairs;

ALTER TABLE Albums DROP CONSTRAINT album_fkey;
ALTER TABLE Photos DROP CONSTRAINT photo_album_fkey;

DROP TABLE Tags;
DROP TABLE Photos;
DROP TABLE Albums;
DROP TABLE Participants;
DROP TABLE User_Events;
DROP TABLE Education;
DROP TABLE Programs;
DROP TABLE Messages;
DROP TABLE Friends;
DROP TABLE User_Hometown_Cities;
DROP TABLE User_Current_Cities;
DROP TABLE Cities;
DROP TABLE Users;