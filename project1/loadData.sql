INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
-- idk if need distinct
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
FROM project1.Public_User_Information;

INSERT INTO Cities (city_id, city_name, state_name, country_name)
SELECT city_seq.NEXTVAL, city_name, state_name, country_name
FROM (
    SELECT DISTINCT current_city AS city_name, current_state AS state_name, current_country AS country_name
    FROM project1.Public_User_Information
    UNION
    SELECT DISTINCT hometown_city AS city_name, hometown_state AS state_name, hometown_country AS country_name
    FROM project1.Public_User_Information
    UNION
    SELECT DISTINCT event_city AS city_name,event_state AS state_name, event_country AS country_name
    FROM project1.Public_Event_Information
);

INSERT INTO User_Current_Cities (user_id, current_city_id)
-- idk if need distinct
SELECT DISTINCT p.user_id, c.city_id
FROM project1.Public_User_Information p
JOIN Cities c ON p.current_city = c.city_name AND p.current_state = c.state_name AND p.current_country = c.country_name;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
-- idk if need distinct
SELECT DISTINCT p.user_id, c.city_id
FROM project1.Public_User_Information p
JOIN Cities c ON p.hometown_city = c.city_name AND p.hometown_state = c.state_name AND p.hometown_country = c.country_name;

INSERT INTO User_Events (event_id, event_creator_id, event_name, event_tagline, event_description, event_host, event_type, event_subtype, event_address, event_city_id, event_start_time, event_end_time)
SELECT DISTINCT p.event_id, p.event_creator_id, p.event_name, p.event_tagline, p.event_description, p.event_host, p.event_type, p.event_subtype, p.event_address, c.city_id, p.event_start_time, p.event_end_time
FROM project1.Public_Event_Information p
JOIN Cities c ON p.event_city = c.city_name AND p.event_state = c.state_name AND p.event_country = c.country_name;


INSERT INTO Programs (program_id, institution, concentration, degree)
SELECT program_seq.NEXTVAL, institution_name, program_concentration, program_degree
FROM (
    SELECT DISTINCT institution_name AS institution, 
                    program_concentration AS concentration, 
                    program_degree AS degree
    FROM project1.Public_User_Information
    WHERE institution_name IS NOT NULL
);

INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT d.user_id, p.program_id, d.program_year
FROM project1.Public_User_Information d
INNER JOIN Programs p WHERE d.institution_name=p.institution AND d.program_concentration=p.concentration AND d.program_degree=p.degree;

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT DISTINCT photo_id, album_id, photo_caption, photo_created_time,    photo_modified_time, photo_link
FROM project1.Public_Photo_Information;

INSERT INTO Albums (album_id, album_owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id)
SELECT DISTINCT album_id, owner_id, album_name, album_created_time,    album_modified_time, album_link, album_visibility, cover_photo_id
FROM project1.Public_Photo_Information;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT DISTINCT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM project1.Public_Tag_Information;

INSERT INTO Friends (user1_id, user2_id)
SELECT user1_id, user2_id
FROM project1.Public_Are_Friends
WHERE user1_id < user2_id;