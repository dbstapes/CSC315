\i ex-create-insert.sql
ls
\i ex-create-insert.sql
ls
\i ex-create-insert.sql
SELECT * FROM AIRPORTS WHERE city = 'Houston'
;
SELECT * FROM AIRPORTS WHERE city = 'Houston'
;
SELECT * FROM AIRPORT WHERE city = 'Houston'
;
\h CREATE INDEX
CREATE TABLE countries (
country_code char(2) PRIMARY KEY,
country_name text UNIQUE
);
INSERT INTO countries (country_code, country_name)
VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'), ('gb','United Kingdom'), ('de','Germany'), ('ll','Loompaland');
INSERT INTO countries VALUES ('uk','United Kingdom');
SELECT * FROM countries;
DELETE FROM countries WHERE country_code = 'll';
CREATE TABLE cities (
name text NOT NULL,
postal_code varchar(9) CHECK (postal_code <> ''),
country_code char(2) REFERENCES countries,
PRIMARY KEY (country_code, postal_code)
);
INSERT INTO cities
VALUES ('Toronto','M4C1B5','ca'); 
INSERT INTO cities
VALUES ('Portland','87200','us');
UPDATE cities
SET postal_code = '97206'
WHERE name = 'Portland';
SELECT cities.*, country_name
FROM cities INNER JOIN countries /* or just FROM cities JOIN countries */
ON cities.country_code = countries.country_code;
CREATE TABLE venues (
venue_id SERIAL PRIMARY KEY,
name varchar(255),
street_address text,
type char(7) CHECK ( type in ('public','private') ) DEFAULT 'public',
postal_code varchar(9),
country_code char(2),
FOREIGN KEY (country_code, postal_code)
REFERENCES cities (country_code, postal_code) MATCH FULL
);
INSERT INTO venues (name, postal_code, country_code)
VALUES ('Crystal Ballroom', '97206', 'us');
SELECT v.venue_id, v.name, c.name
FROM venues v INNER JOIN cities c
ON v.postal_code=c.postal_code AND v.country_code=c.country_code;
INSERT INTO venues (name, postal_code, country_code)
VALUES ('Voodoo Doughnut', '97206', 'us') RETURNING venue_id;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues
);
SELECT * FROM venues;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY(venue_id)
REFERENCES venues(venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id FOREIGN KEY (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp,
FOREIGN KEY (ven_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues(venue_id)
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id);
ALTER TABLE events
ADD
venue_id int
REFERENCES venues (venue_id);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00'),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00');
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00',''),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00','');
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00',NULL),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00',NULL);
SELECT e.title, v.name
FROM events e LEFT JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e LEFT JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e RIGHT JOIN venues v
ON e.venue_id = v.venue_id;
CREATE INDEX events_title
ON events USING hash (title);
SELECT *
FROM events
WHERE starts >= '2018-04-01';
CREATE INDEX events_starts
ON events USING btree (starts);
\di
\s nizar_mohammad_assgn3_day1.txt
INSERT INTO countries (country_code, country_name) 
VALUES ('ch','Chad');
INSERT INTO cities 
VALUES ('Sarh','12345','ch')
;
INSERT INTO venues (name, street_address, postal_code, country_code)
VALUES ('My place', '59 Paul Robeson Rd', '12345
', 'ch');
INSERT INTO venues (name, street_address, postal_code, country_code)
VALUES ('My place', '59 Paul Robeson Rd', '12345','ch');
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Mario Day', '2023-03-10 00:00:00', '2023-03-10 23:59:00', 3),
('Cinco de Mayo', '2023-05-05 00:00:00', '2023-05-05 23:59:00', 1),
('Anniversary', '2023-05-12 00:00:00', '2023-05-12 23:59:00', 2),
('Birthday', '2023-06-22 00:00:00', '2023-06-22 23:59:00', NULL);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Mario Day', '2023-03-10 00:00:00', '2023-03-10 23:59:00', 2),
('Cinco de Mayo', '2023-05-05 00:00:00', '2023-05-05 23:59:00', 1),
('Anniversary', '2023-05-12 00:00:00', '2023-05-12 23:59:00', 2),
('Birthday', '2023-06-22 00:00:00', '2023-06-22 23:59:00', NULL);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Moby', '2018-02-06 21:00', '2018-02-06 23:00', (
SELECT venue_id
FROM venues
WHERE name = 'Crystal Ballroom'
)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Wedding', '2018-02-26 21:00', '2018-02-26 23:00', (
SELECT venue_id
FROM venues
WHERE name = 'Voodoo Doughnut'
)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Dinner with Mom', '2018-02-26 18:00', '2018-02-26 20:30', (
SELECT venue_id
FROM venues
WHERE name = 'My Place'
)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Valentine''s Day', '2018-02-14 00:00', '2018-02-14 23:59', (
SELECT venue_id
FROM venues
WHERE name = ''
)
);
SELECT count(title)
FROM events
WHERE title LIKE '%Day%';
SELECT min(starts), max(ends)
FROM events INNER JOIN venues
ON events.venue_id = venues.venue_id
WHERE venues.name = 'Crystal Ballroom';
SELECT count(*) FROM events WHERE venue_id = 1;
SELECT count(*) FROM events WHERE venue_id = 2;
SELECT count(*) FROM events WHERE venue_id = 3;
SELECT count(*) FROM events WHERE venue_id = IS NULL;
SELECT venue_id, count(*)
FROM events
GROUP BY venue_id;
\s nizar_mohammad_assgn3_day2.txt 
SELECT * FROM airport
;
CREATE VIEW depart_first_leg (
SELECT fl.departure_airport_code 
FROM flight_leg fl 
WHERE fl.leg_number = 1);
SELECT * FROM flight_leg
;
CREATE VIEW depart_first_leg (
SELECT fl.departure_airport_code 
FROM flight_leg fl 
WHERE fl.leg_number = 1);
CREATE VIEW depart_first_leg (
SELECT fl.departure_airport_code 
FROM flight_leg fl 
WHERE leg_number = 1);
SELECT fl.departure_airport_code 
FROM flight_leg fl 
WHERE leg_number = 1;
CREATE VIEW depart_first_leg AS (
SELECT fl.departure_airport_code 
FROM flight_leg fl 
WHERE leg_number = 1);
CREATE VIEW arrival_last_leg AS (
SELECT fl.arrival_airport_code
FROM flight_leg fl
WHERE max(leg_number)
);
CREATE VIEW arrival_last_leg AS (
SELECT fl.arrival_airport_code
FROM flight_leg fl
WHERE leg_number = max(leg_number)
);
SELECT max(leg_number)
FROM flight_leg
;
SELECT * FROM flight_leg;
CREATE VIEW arrival_last_leg AS (
SELECT fl.arrival_airport_code
FROM flight_leg fl
WHERE leg_number = 2
);
CREATE VIEW depart_and_arrive AS (
arrival_last_leg JOIN depart_first_leg);
CREATE VIEW depart_and_arrive AS (
arrival_last_leg JOIN depart_first_leg);
CREATE VIEW depart_and_arrive AS (
arrival_last_leg JOIN depart_first_leg
ON flight_number);
arrival_last_leg
;
SELECT * FROM arrival_last_leg
;
SELECT * FROM dep
CREATE VIEW depart_and_arrive AS (
arrival_last_leg JOIN depart_first_leg
ON airport_code);
CREATE VIEW depart_and_arrive AS (
arrival_last_leg JOIN depart_first_leg
ON airport_code
;
;
);
CREATE VIEW depart_and_arrive AS (
SELECT a.airport_code 
FROM arrival_last_leg a JOIN depart_first_leg b
ON a.airport_code=b.airport_code);
SELECT * FROM arrvial_last_leg;
SELECT * FROM arrival_last_leg;
SELECT fl.flight_number, fl.departure_airport_code, fl.arrival_airport_code
FROM flight_leg fl;
SELECT * FROM events;
SELECT * FROM venues;
SELECT * FROM venue;
SELECT * FROM venueS;
\h CREATE INDEX
CREATE TABLE countries (
country_code char(2) PRIMARY KEY,
country_name text UNIQUE
);
INSERT INTO countries (country_code, country_name)
VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'), ('gb','United Kingdom'), ('de','Germany'), ('ll','Loompaland');
INSERT INTO countries VALUES ('uk','United Kingdom');
SELECT * FROM countries;
DELETE FROM countries WHERE country_code = 'll';
CREATE TABLE cities (
name text NOT NULL,
postal_code varchar(9) CHECK (postal_code <> ''),
country_code char(2) REFERENCES countries,
PRIMARY KEY (country_code, postal_code)
);
INSERT INTO cities
VALUES ('Toronto','M4C1B5','ca'); 
INSERT INTO cities
VALUES ('Portland','87200','us');
UPDATE cities
SET postal_code = '97206'
WHERE name = 'Portland';
SELECT cities.*, country_name
FROM cities INNER JOIN countries /* or just FROM cities JOIN countries */
ON cities.country_code = countries.country_code;
CREATE TABLE venues (
venue_id SERIAL PRIMARY KEY,
name varchar(255),
street_address text,
type char(7) CHECK ( type in ('public','private') ) DEFAULT 'public',
postal_code varchar(9),
country_code char(2),
FOREIGN KEY (country_code, postal_code)
REFERENCES cities (country_code, postal_code) MATCH FULL
);
INSERT INTO venues (name, postal_code, country_code)
VALUES ('Crystal Ballroom', '97206', 'us');
SELECT v.venue_id, v.name, c.name
FROM venues v INNER JOIN cities c
ON v.postal_code=c.postal_code AND v.country_code=c.country_code;
INSERT INTO venues (name, postal_code, country_code)
VALUES ('Voodoo Doughnut', '97206', 'us') RETURNING venue_id;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues
);
SELECT * FROM venues;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY(venue_id)
REFERENCES venues(venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id FOREIGN KEY (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp,
FOREIGN KEY (ven_id)
REFERENCES venues (venue_id) MATCH FULL
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues(venue_id)
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);
ALTER TABLE events
ADD CONSTRAINT venue_id
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id);
ALTER TABLE events
ADD
venue_id int
REFERENCES venues (venue_id);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00'),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00');
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00',''),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00','');
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00',NULL),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00',NULL);
SELECT e.title, v.name
FROM events e LEFT JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e LEFT JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e RIGHT JOIN venues v
ON e.venue_id = v.venue_id;
CREATE INDEX events_title
ON events USING hash (title);
SELECT *
FROM events
WHERE starts >= '2018-04-01';
CREATE INDEX events_starts
ON events USING btree (starts);
\di
SELECT * FROM venues;
/q
\q
SELECT * FROM venues;
SELECT * FROM events
;
SELECT venue_id, couny(*)
;
SELECT venue_id, country(*)
FROM events
GROUP BY venue_id;
SELECT venue_id, count(*)
FROM events
GROUP BY venue_id;
DROP TABLE events;
\q
SELECT * FROM venues;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
text title,
;
);
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id int REFERENCES venues
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club'.'2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00', NULL),
('Christmas Day', '2018-02-15 19:30:00' '2018-12-25 23:59:00', NULL)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00', NULL),
('Christmas Day', '2018-02-15 19:30:00' '2018-12-25 23:59:00', NULL)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00', NULL),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00', NULL)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club','2018-02-15 17:30:00','2018-02-15 19:30:00',2),
('April Fools Day','2018-04-01 00:00:00','2018-04-01 23:59:00', NULL),
('Christmas Day', '2018-02-15 19:30:00','2018-12-25 23:59:00', NULL)
;
SELECT e.title, v.name
FROM events e JOIN venues v
ON e.venue_id = v.venue_id;
SELECT e.title, v.name
FROM events e LEFT JOIN venues v
ON e.venue_id = v.venue_id;
CREATE INDEX events_title
ON events USING hash (title);
SELECT * FROM events WHERE event_id = 2;
SELECT *
FROM events
WHERE starts >= '2018-04-01';
CREATE INDEX events_starts
ON events USING btree (starts);
\di
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Moby', '2018-02-06 21:00', '2018-02-06 23:00', (
SELECT venue_id
FROM venues
WHERE name = 'Crystal Ballroom'
)
);
SELECT * FROM countries;
SELECT * FROM cities;
SELECT * FROM venues;
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Wedding', '2018-02-26 21:00', '2018-02-26 23:00', (
SELECT venue_id
FROM venues
WHERE name = 'Voodoo Doughnut'
)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Dinner with Mom', '2018-02-26 18:00', '2018-02-26 20:30', (
SELECT venue_id
FROM venues
WHERE name = 'My Place'
)
);
INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Valentine''s Day', '2018-02-14 00:00', '2018-02-14 23:59', (
SELECT venue_id
FROM venues
WHERE name = ''
)
);
SELECT count(title)
FROM events
WHERE title LIKE '%Day%';
SELECT min(starts), max(ends)
FROM events INNER JOIN venues
ON events.venue_id = venues.venue_id
WHERE venues.name = 'Crystal Ballroom';
SELECT count(*) FROM events WHERE venue_id = 1;
SELECT count(*) FROM events WHERE venue_id = 2;
SELECT count(*) FROM events WHERE venue_id = 3;
SELECT count(*) FROM events WHERE venue_id = IS NULL;
SELECT count(*) FROM events WHERE venue_id IS NULL;
SELECT venue_id, count(*)
FROM events
GROUP BY venue_id;
SELECT venue_id
FROM events
GROUP BY venue_id
HAVING count(*) >= 2 AND venue_id IS NOT NULL;
SELECT venue_id FROM events GROUP BY venue_id;
SELECT DISTINCT venue_id FROM events;
SELECT title, venue_id, count(*)
FROM events
GROUP BY venue_id;
SELECT title, count(*) OVER (PARTITION BY venue_id) FROM events;
BEGIN TRANSACTION;
DELETE FROM events;
ROLLBACK;
SELECT * FROM events;
BEGIN TRANSACTION;
UPDATE account SET total=total+5000.0 WHERE account_id=1337;
UPDATE account SET total=total-5000.0 WHERE account_id=45887;
END;
CREATE OR REPLACE FUNCTION add_event(
title text,
starts timestamp,
ends timestamp,
venue text,
postal varchar(9),
country char(2))
RETURNS boolean AS $$
DECLARE
did_insert boolean := false;
found_count integer;
the_venue_id integer;
BEGIN
SELECT venue_id INTO the_venue_id
FROM venues v
WHERE v.postal_code=postal AND v.country_code=country AND v.name ILIKE venue
LIMIT 1;
IF the_venue_id IS NULL THEN
INSERT INTO venues (name, postal_code, country_code)
VALUES (venue, postal, country)
RETURNING venue_id INTO the_venue_id;
did_insert := true;
END IF;
-- Note: this is a notice, not an error as in some programming languages
RAISE NOTICE 'Venue found %', the_venue_id;
INSERT INTO events (title, starts, ends, venue_id)
VALUES (title, starts, ends, the_venue_id);
RETURN did_insert;
END;
$$ LANGUAGE plpgsql;
\i add_event.sql
SELECT add_event('House Party', '2018-05-03 23:00',
'2018-05-04 02:00', 'Run''s House', '97206', 'us');
createlang 7dbs --list
;
CREATE TABLE logs (
event_id integer,
old_title varchar(255),
old_starts timestamp,
old_ends timestamp,
logged_at timestamp DEFAULT current_timestamp
);
CREATE OR REPLACE FUNCTION log_event() RETURNS trigger AS $$
DECLARE
BEGIN
INSERT INTO logs (event_id, old_title, old_starts, old_ends)
VALUES (OLD.event_id, OLD.title, OLD.starts, OLD.ends);
RAISE NOTICE 'Someone just changed event #%', OLD.event_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER log_events
AFTER UPDATE ON events
FOR EACH ROW EXECUTE PROCEDURE log_event();
UPDATE events
SET ends='2018-05-04 01:00:00'
WHERE title='House Party';
SELECT event_id, old_title, old_ends, logged_at
FROM logs;
CREATE VIEW holidays AS
SELECT event_id AS holiday_id, title AS name, starts AS date
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;
SELECT name, to_char(date, 'Month DD, YYYY') AS date
FROM holidays
WHERE date <= '2018-04-01';
UPDATE events 
SET starts='2018-12-25 00:00:00'
WHERE title='Christmas Day';
SELECT name, to_char(date, 'Month DD, YYYY') AS date
FROM holidays
WHERE date <= '2018-04-01';
ALTER TABLE events
ADD colors text ARRAY;
CREATE OR REPLACE VIEW holidays AS
SELECT event_id AS holiday_id, title AS name, starts AS date, colors
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;
UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day';
EXPLAIN VERBOSE
SELECT *
FROM holidays;
EXPLAIN VERBOSE
SELECT event_id AS holiday_id,
title AS name, starts AS date, colors
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;
CREATE RULE update_holidays AS ON UPDATE TO holidays DO INSTEAD
UPDATE events
SET title = NEW.name,
starts = NEW.date,
colors = NEW.colors
WHERE title = OLD.name;
UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day';
CREATE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
INSERT INTO ...
;
CREATE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
INSERT INTO holidays
;
CREATE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
INSERT INTO holidays
(name, date, holiday_id)
;
INSERT INTO holidays (name, date, colors)
VALUES ('New Years Day','2013-01-01 00:00:00','yellow')
;
INSERT INTO holidays (name, date, colors)
VALUES ('New Years Day','2013-01-01 00:00:00',{'yellow'})
;
INSERT INTO holidays (name, date)
VALUES ('New Years Day','2013-01-01 00:00:00')
;
SELECT * FROM holidays;
SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month;
CREATE TEMPORARY TABLE month_count(month INT);
INSERT INTO month_count VALUES (1),(2),(3),(4),(5),
(6),(7),(8),(9),(10),(11),(12);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month;
CREATE TEMPORARY TABLE month_count(month INT);
INSERT INTO month_count VALUES (1),(2),(3),(4),(5),
(6),(7),(8),(9),(10),(11),(12);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
\dx
CREATE EXTENSION tablefunc;
\dx
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
SELECT * FROM month_count;
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
\s nizar_mohammad_assgn3_day2.txt 
INSERT INTO events 
VALUES ('Fourth of July', '2019-07-04 00:00:00', '2019-07-04 23:59:00', NULL);
INSERT INTO events 
VALUES ('Fourth of July', '2019-07-04 00:00:00', '2019-07-04 23:59:00');
INSERT INTO events (title, starts, ends) 
VALUES ('Fourth of July', '2019-07-04 00:00:00', '2019-07-04 23:59:00');
INSERT INTO events (title, starts, ends) 
VALUES ('Halloween Day', '2020-10-31 00:00:00', '2020-10-31 23:59:00');
SELECT * FROM holidays;
CREATE TEMPORARY TABLE month_count(month INT);
INSERT INTO month_count VALUES (1),(2),(3),(4),(5),
(6),(7),(8),(9),(10),(11),(12);
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;
\s nizar_mohammad_assgn3_day2.txt 
make check
;
\dx
CREATE EXTENSION dict_xsyn;
\dx
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION pg_trgm;
CREATE EXTENSION cube;
\dx
SELECT '1'::cube;
CREATE TABLE genres (
name text UNIQUE,
position integer
);
CREATE TABLE movies (
movie_id SERIAL PRIMARY KEY,
title text,
genre cube
);
CREATE TABLE actors (
actor_id SERIAL PRIMARY KEY,
name text
);
CREATE TABLE movies_actors (
movie_id integer REFERENCES movies NOT NULL,
actor_id integer REFERENCES actors NOT NULL,
UNIQUE (movie_id, actor_id)
);
CREATE INDEX movies_actors_movie_id ON movies_actors (movie_id);
CREATE INDEX movies_actors_actor_id ON movies_actors (actor_id);
CREATE INDEX movies_genres_cube ON movies USING gist (genre);
\i movies_data.sql 
SELECT title FROM movies WHERE title ILIKE 'stardust%';
SELECT title FROM movies WHERE title ILIKE 'stardust_%';
SELECT COUNT(*) FROM movies WHERE title !~* '^the.*';
CREATE INDEX movies_title_pattern ON movies (lower(title) text_pattern_ops);
SELECT levenshtein('bat', 'fads');
SELECT levenshtein('bat', 'fad') fad,
levenshtein('bat', 'fat') fat,
levenshtein('bat', 'bat') bat;
SELECT movie_id, title FROM movies
WHERE levenshtein(lower(title), lower('a hard day nght')) <= 3;
SELECT show_trgm('Avatar');
CREATE INDEX movies_title_trigram ON movies
USING gist (title gist_trgm_ops);
SELECT title
FROM movies
WHERE title % 'Avatre';
SELECT title
FROM movies
WHERE title @@ 'night & day';
SELECT title
FROM movies
WHERE to_tsvector(title) @@ to_tsquery('english', 'night & day');
SELECT to_tsvector('A Hard Day''s Night'),
to_tsquery('english', 'night & day');
SELECT *
FROM movies
WHERE title @@ to_tsquery('english', 'a');
SELECT to_tsvector('english', 'A Hard Day''s Night');
SELECT to_tsvector('simple', 'A Hard Day''s Night');
\dF
\dFd
SELECT ts_lexize('english_stem', 'Day''s');
SELECT to_tsvector('german', 'was machst du gerade?');
EXPLAIN
SELECT *
FROM movies
WHERE title @@ 'night & day';
CREATE INDEX movies_title_searchable ON movies
USING gin(to_tsvector('english', title));
EXPLAIN
SELECT *
FROM movies
WHERE title @@ 'night & day';
EXPLAIN
SELECT *
FROM movies
WHERE to_tsvector('english',title) @@ 'night & day';
SELECT *
FROM actors
WHERE name = 'Broos Wils';
SELECT *
FROM actors
WHERE name % 'Broos Wils';
SELECT title
FROM movies NATURAL JOIN movies_actors NATURAL JOIN actors
WHERE metaphone(name, 6) = metaphone('Broos Wils', 6);
SELECT name, dmetaphone(name), dmetaphone_alt(name),
metaphone(name, 8), soundex(name)
FROM actors;
SELECT * FROM actors
WHERE metaphone(name,8) % metaphone('Robin Williams',8)
ORDER BY levenshtein(lower('Robin Williams'), lower(name));
SELECT * FROM actors WHERE dmetaphone(name) % dmetaphone('Ron');
SELECT name,
cube_ur_coord('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)', position) as score
FROM genres g
WHERE cube_ur_coord('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)', position) > 0;
SELECT *,
cube_distance(genre, '(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)') dist
FROM movies
ORDER BY dist;
SELECT cube_enlarge('(1,1)',1,2);
SELECT title,
cube_distance(genre, '(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)') dist
FROM movies
WHERE cube_enlarge('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)'::cube, 5, 18)
@> genre
ORDER BY dist;
SELECT m.movie_id, m.title
FROM movies m, (SELECT genre, title FROM movies WHERE title = 'Mad Max') s
WHERE cube_enlarge(s.genre, 5, 18) @> m.genre AND s.title <> m.title
ORDER BY cube_distance(m.genre, s.genre)
LIMIT 10;
\s nizar_mohammad_assign3_all_commands.txt
SELECT * FROM airport
;
CREATE VIEW depart_first_leg (
SELECT * FROM flight_leg
WHERE flight_leg.leg_number=1);
SELECT * FROM flight_leg
;
SELECT * FROM flight_leg
WHERE flight_leg.leg_number=1;
CREATE VIEW depart_first_leg AS (
SELECT * FROM flight_leg
WHERE flight_leg.leg_number=1);
DROP VIEW depart_first_leg;
CREATE VIEW depart_first_leg AS (
SELECT * FROM flight_leg
WHERE flight_leg.leg_number=1);
SELECT * FROM flight_leg
;
DROP VIEW depart_first_leg;
CREATE VIEW depart_first_leg AS (
SELECT fl.flight_number, fl.departure_airport_code, a.name FROM flight_leg fl JOIN airport a ON fl.departure_airport_code=a.airport_code
WHERE flight_leg.leg_number=1);
CREATE VIEW depart_first_leg AS (
SELECT fl.flight_number, fl.departure_airport_code, a.name FROM flight_leg fl JOIN airport a ON fl.departure_airport_code=a.airport_code
WHERE fl.leg_number=1);
depart_first_leg
;
SELECT * FROM depart_first_leg;
ALTER VIEW depart_first_leg RENAME COLUMN name TO departure_airport;
SELECT * FROM depart_first_leg;
SELECT max(leg_number) FROM flight_leg;
SELECT fl.flight_number, fl.arrival_airport_code, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code
WHERE fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.flight_number, fl.arrival_airport_code, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT arrival_airport_code, max(leg_number)
FROM  flight_leg
GROUP BY arrival_airport_code;
SELECT fl.flight_number, fl.arrival_airport_code, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.arrival_airport_code, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.arrival_airport_code FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.arrival_airport_code FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.arrival_airport_code, fl.leg_number, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
CREATE VIEW arrival_last_leg AS (SELECT fl.arrival_airport_code, fl.leg_number, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max);
DROP VIEW arrival_last_leg;
CREATE VIEW arrival_last_leg AS (SELECT fl.arrival_airport_code, fl.leg_number, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max);
ALTER VIEW arrival_last_leg RENAME COLUMN name TO arrival_airport;
SELECT * FROM depart_first_leg;
SELECT * FROM arrival_last_leg;
DROP VIEW arrival_last_leg;
CREATE VIEW arrival_last_leg AS (SELECT fl.flight_number, fl.arrival_airport_code, fl.leg_number, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY flight_number, arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max);
SELECT * FROM arrival_last_leg;
CREATE VIEW depart_and_arrive AS (
SELECT dl.flight_number, dl.departure_airport, al.name
FROM departure_first_leg dl JOIN arrival_last_leg al
ON dl.flight_number=al.flight_number);
CREATE VIEW depart_and_arrive AS (
SELECT dl.flight_number, dl.departure_airport, al.name
FROM depart_first_leg dl JOIN arrival_last_leg al
ON dl.flight_number=al.flight_number);
SELECT * FROM depart_and_arrive;
DROP VIEW depart_and_arrive;
DROP VIEW arrival_last_leg;
SELECT fl.arrival_airport_code FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.arrival_airport_code, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY arrival_airport_code
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT fl.flight_number, fl.arrival_airport_code, fl.leg_number, a.name FROM
flight_leg fl JOIN airport a ON fl.arrival_airport_code=a.airport_code GROUP BY flight_number, arrival_airport_code, leg_number, name
HAVING fl.leg_number=(SELECT max(leg_number) FROM flight_leg).max;
SELECT flight_number, arrival_airport_code
FROM flight_leg;
SELECT flight_number, arrival_airport_code, leg_number
FROM flight_leg
GROUP BY flight_number;
SELECT flight_number, arrival_airport_code, max(leg_number)
FROM flight_leg
GROUP BY flight_number;
SELECT flight_number, arrival_airport_code, max(leg_number)
FROM flight_leg
GROUP BY flight_number, arrival_airport_code;
SELECT * FROM flight_leg;
SELECT arrival_airport_code, max(leg_number)
lion-# FROM  flight_leg
lion-# GROUP BY arrival_airport_code;
SELECT arrival_airport_code, max(leg_number)
lion-# FROM flight_leg
lion-# GROUP BY arrival_airport_code;
SELECT arrival_airport_code, max(leg_number)
lion-#FROM flight_leg
lion-#GROUP BY arrival_airport_code;
SELECT arrival_airport_code, max(leg_number)
lion-# FROM  flight_leg
lion-# GROUP BY arrival_airport_code;
SELECT * FROM flight_leg;
SELECT arrival_airport_code, max(leg_number)
lion-# FROM  flight_leg
lion-# GROUP BY arrival_airport_code;
SELECT arrival_airport_code, max(leg_number)
FROM flight_leg
GROUP BY arrival_airport_code;
ALTER VIEW depart_first_log
;
DROP VIEW depart_first_leg;
CREATE VIEW depart_first_leg AS (
SELECT fl.flight_number, fl.departure_airport_code, a.name FROM flight_leg fl JOIN airport a ON fl.departure_airport_code=a.airport_code
WHERE fl.leg_number=1);
DROP VIEW depart_first_leg;
CREATE VIEW depart_first_leg AS (
SELECT fl.flight_number, fl.departure_airport_code, a.name, fl.arrival_airport_code FROM flight_leg fl JOIN airport a ON fl.departure_airport_code=a.airport_code
WHERE fl.leg_number=1);
ALTER VIEW depart_first_leg RENAME COLUMN name TO departure_airport;
SELECT * FROM depart_first_leg;
SELECT * FROM flight_leg;
SELECT *
FROM depart_first_leg LEFT JOIN flight_leg
ON depart_first_leg.arrival_airport_code=flight_leg.departure_airport_code AND
flight_leg.leg_number=2;
SELECT *
FROM depart_first_leg LEFT JOIN flight_leg
ON depart_first_leg.arrival_airport_code=flight_leg.departure_airport_code AND
flight_leg.leg_number=2;
SELECT flight_number, departure_airport, leg_number, arrival_airport_code
FROM depart_first_leg LEFT JOIN flight_leg
ON depart_first_leg.arrival_airport_code=flight_leg.departure_airport_code AND
flight_leg.leg_number=2;
SELECT dl.flight_number, dl.departure_airport, leg_number, arrival_airport_code
FROM dl depart_first_leg LEFT JOIN flight_leg
ON dl.arrival_airport_code=flight_leg.departure_airport_code AND
flight_leg.leg_number=2;
SELECT dl.flight_number, dl.departure_airport, leg_number, arrival_airport_code
FROM depart_first_leg dl LEFT JOIN flight_leg
ON dl.arrival_airport_code=flight_leg.departure_airport_code AND
flight_leg.leg_number=2;
SELECT dl.flight_number, dl.departure_airport, fl.leg_number, fl.arrival_airport_code
FROM depart_first_leg dl LEFT JOIN flight_leg fl
ON dl.arrival_airport_code=fl.departure_airport_code AND
fl.leg_number=2;
SELECT * FROM flight_leg;
SELECT dl.flight_number, dl.departure_airport, fl.leg_number, fl.arrival_airport_code
FROM depart_first_leg dl JOIN flight_leg fl
ON dl.arrival_airport_code=fl.departure_airport_code AND
fl.leg_number=2;
SELECT * FROM depart_first_leg;
SELECT fl.flight_numberm, fl.departure_airport_code, fl.arrival_airport_code, a.name,  max(fl.leg_number) 
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
GROUP BY flight_number, departure_airport_code, arrival_airport_code, name;
SELECT fl.flight_number, fl.departure_airport_code, fl.arrival_airport_code, a.name,  max(fl.leg_number) 
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
GROUP BY flight_number, departure_airport_code, arrival_airport_code, name;
CREATE VIEW arrival_last_leg AS (SELECT fl.flight_number, fl.departure_airport_code, fl.arrival_airport_code, a.name,  max(fl.leg_number) 
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
GROUP BY flight_number, departure_airport_code, arrival_airport_code, name);
ALTER VIEW arrival_last_leg RENAME COLUMN name TO arrival_airport;
SELECT * FROM depart_first_leg;
SELECT * FROM arrival_last_leg;
SELECT dl.flight_number, dl.departure_airport, al.arrival_airport
FROM depart_first_leg dl JOIN arrival_last_leg al
ON dl.flight_number=al.flight_number;
SELECT * FROM flight_leg;
\i ex-create-insert.sql
SELECT * FROM flight_leg;
CREATE VIEW depart_first_leg AS (
SELECT fl.flight_number, fl.departure_airport_code, a.name, fl.arrival_airport_code FROM flight_leg fl JOIN airport a ON fl.departure_airport_code=a.airport_code
WHERE fl.leg_number=1);
ALTER VIEW depart_first_leg RENAME COLUMN name TO departure_airport;
CREATE VIEW arrival_last_leg AS (SELECT fl.flight_number, fl.departure_airport_code, fl.arrival_airport_code, a.name,  max(fl.leg_number) 
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
GROUP BY flight_number, departure_airport_code, arrival_airport_code, name);
ALTER VIEW arrival_last_leg RENAME COLUMN name TO arrival_airport;
SELECT dl.flight_number, dl.departure_airport, al.arrival_airport
FROM depart_first_leg dl JOIN arrival_last_leg al
ON dl.flight_number=al.flight_number;
SELECT f.flight_number, f.weekdays, fl.departure_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number;
SELECT f.flight_number, f.weekdays, fl.departure_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number
WHERE fl.departure_airport_code='iah';
CREATE VIEW hou_airports AS (SELECT f.flight_number, f.weekdays, fl.departure_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number
WHERE fl.departure_airport_code='iah');
SELECT f.flight_number, fl.departure_airport_code, fl.arrival_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number 
WHERE fl.arrival_airport_code='lax';
CREATE VIEW la_arrival AS (SELECT f.flight_number, fl.departure_airport_code, fl.arrival_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number 
WHERE fl.arrival_airport_code='lax');
SELECT h.flight_number, h.weekdays
FROM hou_airports JOIN la_arrival
ON h.flight_number=l.flight_number AND h.departure_airport_code=l.departure_airport_code;
SELECT h.flight_number, h.weekdays
FROM hou_airports h JOIN la_arrival l
ON h.flight_number=l.flight_number AND h.departure_airport_code=l.departure_airport_code;
CREATE VIEW hou_airports AS (SELECT f.flight_number, f.weekdays, fl.departure_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number
WHERE fl.departure_airport_code='iah');
CREATE VIEW la_arrival AS (SELECT f.flight_number, fl.departure_airport_code, fl.arrival_airport_code
FROM flight f JOIN flight_leg fl
ON f.flight_number=fl.flight_number 
WHERE fl.arrival_airport_code='lax');
SELECT h.flight_number, h.weekdays
FROM hou_airports h JOIN la_arrival l
ON h.flight_number=l.flight_number AND h.departure_airport_code=l.departure_airport_code;
SELECT * FROM flight_leg JOIN flight ON flight_leg.flight_number=flight.flight_number;
SELECT * FROM flight;
SELECT * FROM airport;
SELECT fl.flight_number, fl.departure_airport_code, fl.scheduled_departure_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.departure_airport_code=a.airport_code
WHERE a.city='Houston';
CREATE VIEW hou_depart AS (SELECT fl.flight_number, fl.departure_airport_code, fl.scheduled_departure_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.departure_airport_code=a.airport_code
WHERE a.city='Houston');
SELECT fl.flight_number, fl.arrival_airport_code, fl.scheduled_arrival_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
WHERE a.city='Los Angeles';
CREATE VIEW la_arr AS (SELECT fl.flight_number, fl.arrival_airport_code, fl.scheduled_arrival_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
WHERE a.city='Los Angeles');
SELECT * FROM hou_depart JOIN la_arr
ON hou_depart.flight_number=la_arr.flight_number;
CREATE VIEW hou_to_la AS (SELECT * FROM hou_depart JOIN la_arr
ON hou_depart.flight_number=la_arr.flight_number);
SELECT * FROM hou_depart JOIN la_arr
ON hou_depart.flight_number=la_arr.flight_number;
CREATE VIEW hou_to_la AS (SELECT * FROM hou_depart JOIN la_arr
ON hou_depart.flight_number=la_arr.flight_number);
CREATE VIEW hou_to_la AS (SELECT h.flight_number, h.departure_airport_code, h.scheduled_departure_time, l.arrival_airport_code, l.schedulded_arrival_time FROM hou_depart h JOIN la_arr l
ON h.flight_number=l.flight_number);
CREATE VIEW hou_to_la AS (SELECT h.flight_number, h.departure_airport_code, h.scheduled_departure_time, l.arrival_airport_code, l.scheduled_arrival_time FROM hou_depart h JOIN la_arr l
ON h.flight_number=l.flight_number);
SELECT * FROM hou_to_la;
SELECT * FROM hou_to_la JOIN flight
ON hou_to_la.flight_number = flight.flight_number;
SELECT weekdays FROM flight;
SELECT weekdays FROM flight JOIN hou_to_la ON flight.flight_number = hou_to_la.flight_number;
CREATE VIEW hou_to_la_weekdays AS (SELECT weekdays FROM flight JOIN hou_to_la ON flight.flight_number = hou_to_la.flight_number);
SELECT * FROM hou_to_la JOIN hou_to_la_weekdays
ON hou_to_la.flight_number = hou_to_la_weekdays.flight_number;
DROP VIEW hou_to_la_weekdays;
CREATE VIEW hou_to_la_weekdays AS (SELECT f.weekdays, f.flight_number FROM flight f JOIN hou_to_la ON f.flight_number = hou_to_la.flight_number);
SELECT * FROM hou_to_la_weekdays;
SELECT * FROM hou_to_la JOIN hou_to_la_weekdays ON hou_to_la.flight_number=hou_to_la_weekdays.flight_number;
CREATE VIEW hou_depart AS (SELECT fl.flight_number, fl.departure_airport_code, fl.scheduled_departure_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.departure_airport_code=a.airport_code
WHERE a.city='Houston');
CREATE VIEW la_arr AS (SELECT fl.flight_number, fl.arrival_airport_code, fl.scheduled_arrival_time, a.city
FROM flight_leg fl JOIN airport a
ON fl.arrival_airport_code=a.airport_code
WHERE a.city='Los Angeles');
CREATE VIEW hou_to_la AS (SELECT h.flight_number, h.departure_airport_code, h.scheduled_departure_time, l.arrival_airport_code, l.scheduled_arrival_time FROM hou_depart h JOIN la_arr l
ON h.flight_number=l.flight_number);
CREATE VIEW hou_to_la_weekdays AS (SELECT f.weekdays, f.flight_number FROM flight f JOIN hou_to_la ON f.flight_number = hou_to_la.flight_number);
SELECT * FROM hou_to_la JOIN hou_to_la_weekdays ON hou_to_la.flight_number=hou_to_la_weekdays.flight_number;
CREATE TABLE municipality_code (
Municipality_index SERIAL PRIMARY KEY,
Municipality_name varchar(30),
County varchar(30));
CREATE TABLE municipality (
bigint Residential_electricity,
bigint Commercial_electricity,
bigint Industrial_elec);
CREATE TABLE municipality (
Residential_electricity bigint,);
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigin,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
Municapility_index PRIMARY KEY, 
);

REFERENCES municipality_code (Municipality_index, County) MATCH FULL );
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigin,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
);
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigin,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
Year int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index, County) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigint,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
Year int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index, County) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigint,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
Year int, Municipality_index int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index, County) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigint,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
Year int, Municipality_index int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index, County) REFERENCES municipality_code (Municipality_index, County)
MATCH FULL );
CREATE TABLE municipality (
Residential_electricity bigint,
Commercial_electricity bigint,
Industrial_electricity bigint,
Street_light_electricity bigint,
Residential_gas bigint,
Commercial_gas bigint,
Industrial_gas bigint,
Street_light_gas bigint,
Gas_utility bigint,
Electric_utility bigint, 
County varchar(30), 
Year int, Municipality_index int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE energy_efficiency_programs (
Municipality_index int,
Num_CI_taxed_parcels int,
Total_completed_projects int,
current_lifetime_rate float,
Num_projects_needed int,
PRIMARY KEY (Municipality_index),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE solar_installation_programs (
Application_number text,
Municipality_index int,
Status text,
Third_party_ownership varchar(3),
Program text, 
PTO_date timestamp,
Calculated_system_size float,
Contractor text, 
Interconnection text,
Utility_name text,
PRIMARY KEY (Application_number),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );
CREATE TABLE commercial_solar_customer (
Application_number text,
Premise_company text,
premise_installation_address text,
PRIMARY KEY (Application_number),
FOREIGN KEY (Application_number) REFERENCES solar_installation_programs (Application_number)
MATCH FULL );
\s create_table_commands.txt
\s create_table_commands.sql
