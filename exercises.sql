-- Easy 1

-- 1
createdb animals -- from terminal
CREATE DATABASE animals -- from psql console

-- 2
CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(25),
  age integer,
  species varchar(15)
);

-- 3
INSERT INTO birds (name, age, species) VALUES
  ('Charlie', 3, 'Finch'),
  ('Allie', 5, 'Owl'),
  ('Jennifer', 3, 'Magpie'),
  ('Jamie', 4, 'Owl'),
  ('Roy', 8, 'Crow');

-- 4
SELECT * FROM birds;

-- 5
SELECT * FROM birds WHERE age < 5;

-- 6
UPDATE birds
SET species = 'Raven'
WHERE species = 'Crow';
-- Further Exploration
UPDATE birds
SET species = 'Hawk'
WHERE name = 'Jamie';

-- 7
DELETE FROM birds
WHERE species = 'Finch' AND age = 3;

-- 8
-- Optional constraint name omitted (default name is table_column_check)
ALTER TABLE birds
ADD CHECK (age > 0);
-- With optional constraint name
ALTER TABLE birds
ADD CONSTRAINT no_negative_age
CHECK (age > 0);
-- Test bad insert
INSERT INTO birds (name, age, species) VALUES
  ('Bob', -5, 'Cardinal');

-- 9
DROP TABLE birds;

-- 10
DROP DATABASE animals;

-- Lesson 2 Practice Problems
--1 SQL is a declarative programming language, also called a special purpose language, that 
-- is used to manipulate the schema and data of tables stored in a relational database

--2 Data definition lanuage, data manipulation language and data control language make up SQL

--3 'canoe', 'a long road', 'weren''t', '"No way!"'

--4 concat() or ||

--5 lower()

--6 t and f

--7 
select trunc(4 * pi() * pow(26.3, 2)); --or
select trunc(4 * pi() * 26.3 ^ 2);

-- DML, DDL, and DCL
-- Done

-- Working with a Single Table

-- 1
CREATE TABLE people (
  name varchar(255),
  age integer,
  occupation varchar(255)
);

-- 2
INSERT INTO people
  VALUES ('Abby', 34, 'biologist'),
         ('Mu''nisah', 26, null),
         ('Mirabelle', 40, 'contractor');
         
-- 3
SELECT name, age, occupation FROM people WHERE name = 'Mu''nisah';
SELECT * FROM people WHERE age = 26;
SELECT * FROM people WHERE occupation is NULL;

-- 4
CREATE TABLE birds (
  name varchar(255),
  length decimal(4,1),
  wingspan decimal(4,1),
  family varchar(255), -- or text
  extinct boolean
);

-- 5
INSERT INTO birds VALUES
  ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
  ('American Robin', 25.5, 36.0, 'Turdidae', false),
  ('Greater Koa Finch', 19.0,	24.0,	'Fringillidae', true),
  ('Carolina Parakeet', 33.0,	55.8,	'Psittacidae', true),
  ('Common Kestrel', 35.5, 73.5, 'Falconidae',	false);

-- 6
SELECT name, family FROM birds WHERE extinct = false ORDER BY length DESC;

-- 7
SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;

-- 8
CREATE TABLE menu_items (
  item varchar(30) -- or text
  prep_time integer,
  ingredient_cost decimal(4,2), -- or numeric
  sales integer,
  menu_price decimal(4,2)
);

-- 9
INSERT INTO menu_items VALUES ('omelette', 10, 1.50, 182, 7.99);
INSERT INTO menu_items VALUES ('tacos', 5, 2.00, 254, 8.99);
INSERT INTO menu_items VALUES ('oatmeal', 1, 0.50, 79, 5.99);

-- 10
SELECT item, menu_price - ingredient_cost AS profit FROM menu_items ORDER BY profit DESC LIMIT 1;

-- 11
SELECT item, menu_price, ingredient_cost,
  ((prep_time / 60.0) * 13.0) AS labor,
  menu_price - ingredient_cost - ((prep_time / 60.0) * 13.0) AS profit
  FROM menu_items ORDER BY profit DESC;

SELECT item, menu_price, ingredient_cost,
 round(prep_time/60.0 * 13.0, 2) AS labor,
 menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit
FROM menu_items
ORDER BY profit DESC;

-- Residents exercises:
-- 3
SELECT state, count(state) FROM people GROUP BY state ORDER BY count(state) DESC LIMIT 10;

--4
SELECT substring(email from '@(.+)') AS domain, count(id) FROM people GROUP BY domain ORDER BY count DESC;
-- or
SELECT substr(email, strpos(email, '@') + 1) AS domain, count(id) FROM people GROUP BY domain ORDER BY count DESC;

-- 5
DELETE FROM people WHERE id = 3399;

-- 6
DELETE FROM people WHERE state = 'CA';

-- 7
UPDATE people
SET given_name = upper(given_name)
WHERE substr(email, strpos(email, '@') + 1) = 'teleworm.us'; -- or LIKE '%teleworm.us'

-- Not NULL and DEFAULT values
-- 3
CREATE TABLE temperatures (
  "date" date NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL
);

-- 4
INSERT INTO temperatures VALUES
  ('2016-03-01', 34, 43),
  ('2016-03-02', 32, 44),
  ('2016-03-03', 31, 47),
  ('2016-03-04', 33, 42),
  ('2016-03-05', 39, 46),
  ('2016-03-06', 32, 43),
  ('2016-03-07', 29, 32),
  ('2016-03-08', 23, 31),
  ('2016-03-09', 17, 28);
  
-- 5
SELECT date, ROUND((low + high) / 2.0, 1) AS average
  FROM temperatures
 WHERE date >= '2016-03-02' AND date <= '2016-03-08';
 -- casting as a decimal and using between comparison predicate
SELECT date, ((low + high) / 2.0)::decimal(3,1) AS average
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';
 
-- 6
ALTER TABLE temperatures
ADD COLUMN rainfall integer DEFAULT 0;

-- 7
UPDATE temperatures
SET rainfall = ((low + high) / 2) - 35
WHERE ((low + high) / 2) - 35 > 0;

-- 8
ALTER TABLE temperatures
ALTER COLUMN rainfall TYPE numeric(6,3);

UPDATE temperatures
SET rainfall = round(rainfall / 25.4, 3);

-- 9
ALTER TABLE temperatures RENAME TO weather;

-- DDL (Data Definition Language)
-- 1
CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1) UNIQUE,
  mass integer
);

-- 2
ALTER TABLE planets ADD COLUMN
  star_id integer NOT NULL REFERENCES stars (id);
  
-- 3
ALTER TABLE stars ALTER COLUMN name TYPE varchar(50);
-- Further Exploration
-- Changing the data type in the table works as long as all the data already
-- existing in the table conforms to what you're changing it to.
-- if not an error will be thrown, e.g.
-- ERROR:  value too long for type character varying(1) and you will have to 
-- change the data first.

-- 4
ALTER TABLE stars ALTER COLUMN distance TYPE decimal;
-- Further Exploration
-- No error is thrown because the data type is still numeric. If you had data
-- with a decimal and then change to integer, the decimal will be converted
-- to an integer. Changing back to decimal would lose that precision.

-- 5
ALTER TABLE stars ADD CHECK (spectral_type SIMILAR TO '%(O|B|A|F|G|K|M)%');
ALTER TABLE stars ALTER COLUMN spectral_type SET NOT NULL;
-- or
ALTER TABLE stars ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));

-- FE
-- if you tried adding the above constraints with data existing in the rows
-- that violated the constraint, you would get an error:
-- ERROR:  column "spectral_type" contains null values
-- ERROR:  check constraint "stars_spectral_type_check" is violated by some row
-- The work around would be to delete data that is null or has a violation and then
-- insert conforming data
DELETE FROM stars WHERE spectral_type NOT IN ('O', 'B', 'A', 'F', 'G', 'K', 'M') OR spectral_type IS NULL;

ALTER TABLE stars ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;

-- 6
ALTER TABLE stars DROP CONSTRAINT stars_spectral_type_check;
CREATE TYPE spectral_letter AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');
ALTER TABLE stars ALTER COLUMN spectral_type TYPE spectral_letter USING spectral_type::spectral_letter;

-- 7
ALTER TABLE planets ALTER COLUMN mass TYPE numeric,
  ALTER COLUMN mass SET NOT NULL,
  ALTER COLUMN designation SET NOT NULL;

ALTER TABLE planets ADD CHECK (mass > 0.0);

-- 8
ALTER TABLE planets ADD COLUMN semi_major_axis numeric NOT NULL;
-- FE
-- If the table already has existing values you have to add the column without
-- the null constraint, add values to it, and then add the constraint
ALTER TABLE planets ADD COLUMN semi_major_axis numeric;
UPDATE planets SET semi_major_axis = 0.04 WHERE designation = 'b';
UPDATE planets SET semi_major_axis = 40 WHERE designation = 'c';
ALTER TABLE planets ALTER COLUMN semi_major_axis SET NOT NULL;

-- 9
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0.0),
  planet_id integer REFERENCES planets (id)
);

-- 10
-- database dump from terminal
-- pg_dump --inserts extrasolar > lesson_3/extrasolar.dump.sql
DROP DATABASE extrasolar;

-- DML (Data Manipulation Language)
-- 1
CREATE DATABASE workshop;

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices (id)
);

-- 2
INSERT INTO devices (name) VALUES
  ('Accelerometer'),
  ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES
  (5567, 1),
  (3083, 1),
  (7849, 1),
  (4113, 2),
  (4988, 2),
  (9866, 2),
  (1323, 2),
  (6733, 2),
  (4706, NULL),
  (3060, NULL),
  (7831, NULL);
-- Matching the book for convenience
UPDATE parts SET part_number = 12 WHERE id = 1;
UPDATE parts SET part_number = 14 WHERE id = 2;
UPDATE parts SET part_number = 16 WHERE id = 3;
UPDATE parts SET part_number = 31 WHERE id = 4;
UPDATE parts SET part_number = 33 WHERE id = 5;
UPDATE parts SET part_number = 35 WHERE id = 6;
UPDATE parts SET part_number = 37 WHERE id = 7;
UPDATE parts SET part_number = 39 WHERE id = 8;
UPDATE parts SET part_number = 50 WHERE id = 9;
UPDATE parts SET part_number = 54 WHERE id = 10;
UPDATE parts SET part_number = 58 WHERE id = 11;

-- 3
SELECT devices.name, parts.part_number FROM devices
  INNER JOIN parts ON parts.device_id = devices.id;

-- 4
SELECT * FROM parts WHERE position('3' in part_number::text) = 1;
-- or
SELECT * FROM parts WHERE CAST(part_number AS text) LIKE '3%';

-- 5
SELECT devices.name, count(parts.device_id) FROM devices
  JOIN parts ON devices.id = parts.device_id
  GROUP BY devices.name;
-- in the case where a device might not have any parts, you should use left outer join
SELECT devices.name, COUNT(parts.device_id) FROM devices
LEFT OUTER JOIN parts ON devices.id = parts.device_id GROUP BY devices.name;

-- 6
SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name DESC;

-- 7
SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;
SELECT part_number, device_id FROM parts WHERE device_id IS NULL;

-- 8
SELECT name AS oldest_device FROM devices ORDER BY age(created_at) ASC LIMIT 1;

-- 9
UPDATE parts SET device_id = 1 WHERE part_number = 37 OR part_number = 39;
-- FE
-- How can you set the smallest part number to 'Gyroscope'?
-- Using the IN statement
UPDATE parts SET device_id = 2 WHERE part_number IN (SELECT min(part_number) FROM parts);
-- or simply
UPDATE parts SET device_id = 2 WHERE part_number = (SELECT min(part_number) FROM parts);
-- the bottom line is that you need to use queries to narrow down the results
-- to something usable in other queries

-- 10
-- First want to see what is associated with accelerometer
DELETE FROM parts WHERE device_id = (SELECT id FROM devices WHERE name = 'Accelerometer');
DELETE FROM devices WHERE name = 'Accelerometer';
-- FE
-- the constraint ON DELETE CASCADE would allow you to delete the device and all
-- associated parts in one statement. To add this, drop the foreign key constraint
-- and add it back with the extra requirement
ALTER TABLE parts DROP CONSTRAINT parts_device_id_fkey,
  ADD FOREIGN KEY (device_id)
  REFERENCES devices (id)
  ON DELETE CASCADE;
  
-- Then only one delete statement is needed
DELETE FROM devices WHERE name = 'Gyroscope';

WITH devices_parts AS (SELECT * FROM devices JOIN parts ON devices.id = parts.device_id)
SELECT FROM devices_parts WHERE name = 'Accelerometer';

DELETE FROM devices USING parts WHERE devices.id = parts.device_id AND name = 'Accelerometer';

-- Medium: Many to Many
-- 1
CREATE DATABASE billing;

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) UNIQUE NOT NULL CHECK (payment_token ~ '[A-Z]{8}')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token) VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');
  
INSERT INTO services (description, price) VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);
  
CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer NOT NULL REFERENCES customers (id) ON DELETE CASCADE,
  service_id integer NOT NULL REFERENCES services (id),
  UNIQUE (customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (3, 1),
  (3, 2),
  (3, 3),
  (3, 4),
  (3, 5),
  (4, 1),
  (4, 4),
  (5, 1),
  (5, 2),
  (5, 6),
  (6, 1),
  (6, 6),
  (6, 7);

-- 2
SELECT DISTINCT customers.* FROM customers
  JOIN customers_services
  ON customers.id = customers_services.customer_id;

-- 3
SELECT customers.* FROM customers
  LEFT JOIN customers_services
  ON customers.id = customer_id
  WHERE service_id IS NULL;
-- FE
SELECT customers.*, services.* FROM customers
  LEFT JOIN customers_services
  ON customers.id = customers_services.customer_id
  FULL JOIN services
  ON services.id = customers_services.service_id
  WHERE service_id IS NULL OR customer_id IS NULL;

-- 4
SELECT services.description FROM customers_services
  RIGHT JOIN services ON customers_services.service_id = services.id
  WHERE customer_id IS NULL; -- could use service_id here

-- 5
SELECT customers.name, string_agg(services.description, ', ') AS services
FROM customers
  LEFT JOIN customers_services
    ON customers.id = customer_id
  LEFT JOIN services
    ON service_id = services.id
  GROUP BY customers.id;

-- FE
SELECT customers.name,
       lag(customers.name)
         OVER (ORDER BY customers.name)
         AS previous,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;

-- Algorithm
-- When the customer name before is the same, display null
-- When the customer name before is different, display the customer name

SELECT
  CASE lag(customers.name) OVER (ORDER BY customers.name)
    WHEN customers.name THEN NULL
    ELSE customers.name
  END,
  services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;

-- other experiments
SELECT customers.name, services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id
ORDER BY customers.name;

SELECT customers.name, string_agg(services.description, E'\n')
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id
GROUP BY customers.id
ORDER BY customers.name;

-- 6
SELECT services.description, count(DISTINCT customer_id)
FROM services
LEFT JOIN customers_services
ON services.id = service_id
GROUP BY services.description
HAVING count(customer_id) >= 3
ORDER BY description;

-- 7
SELECT sum(price) AS gross
FROM services
JOIN customers_services
ON service_id = services.id;

-- 8
INSERT INTO customers (name, payment_token) VALUES
  ('John Doe', 'EYODHLCN');
  
INSERT INTO customers_services (customer_id, service_id) VALUES
  (8, 1),
  (8, 2),
  (8, 3);

-- 9
-- first sum of services over 100
-- second sum of services if every customer bought every service over 100
SELECT sum(price) FROM services
  JOIN customers_services ON service_id = services.id
  WHERE price > 100;

SELECT sum(price) FROM services
  CROSS JOIN customers_services
  WHERE price > 100;
-- or (user submitted)
SELECT (SELECT COUNT(customers.id) FROM customers) *
(SELECT sum(price) FROM services WHERE price > 100)
AS sum;
-- or (user submitted)
SELECT COUNT(customers.id) *
(SELECT sum(price) FROM services WHERE price > 100)
AS sum
FROM customers;

-- 10
DELETE FROM customers WHERE name = 'Chen Ke-Hua';

DELETE FROM customers_services WHERE service_id = 7;
DELETE FROM services WHERE description = 'Bulk Email';

SELECT * from customers join customers_services on customer_id = customers.id
join services on services.id = service_id
where name = 'Chen Ke-Hua';

-- Quiz
SELECT lu.name AS 'User Name', b.name AS 'Books Checked Out'
  FROM library_users
  
-- Subquery vs join
EXPLAIN SELECT event_id FROM tickets JOIN customers
ON customers.id = tickets.customer_id WHERE last_name = 'Ruecker';

EXPLAIN SELECT event_id FROM tickets WHERE customer_id
IN (SELECT id FROM customers WHERE last_name = 'Ruecker');

-- Medium: Subqueries and More
-- 1
CREATE DATABASE auction;

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL,
  sales_price numeric(6,2)
);
-- didn't have this constraint initially
ALTER TABLE items ADD CHECK (initial_price BETWEEN 0.01 AND 1000.00),
  ADD CHECK (sales_price BETWEEN 0.01 AND 1000.00);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders (id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items (id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL
);

ALTER TABLE bids ADD CHECK (amount BETWEEN 0.01 AND 1000.00);

-- Note, you can't create an index in the CREATE TABLE query other than
-- automatically created indexes for PRIMARY KEY or UNIQUE
-- Also, we don't want this to be a unique index because the same bidder can bid
-- on the same item multiple times
CREATE INDEX ON bids (bidder_id, item_id);

-- using the meta command rather than SQL COPY allows the reading or writing
-- of the specified file to route between the server and local file system
-- the SQL command is the server reading and writing would need absolute file path
-- in this way, the file accessiblity and privileges are those of the local user
\copy bidders FROM 'lesson_4/bidders.csv' WITH csv header -- with is optional, optional boolean for header
\copy items FROM 'lesson_4/items.csv' csv header -- when the format is csv, the default delimeter is ','
\copy bids FROM 'lesson_4/bids.csv' csv header

-- 2
SELECT name AS "Bid on Items" FROM items
WHERE items.id IN (SELECT DISTINCT item_id FROM bids);

-- 3
SELECT name AS "Not Bid On" FROM items
WHERE items.id NOT IN (SELECT DISTINCT item_id FROM bids);

-- 4
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id); -- compares bidders.id because
-- there is a from-clause entry for bidders
-- equivalent result
SELECT name FROM bidders WHERE id IN (SELECT DISTINCT bidder_id FROM bids);
-- equivalent result
SELECT DISTINCT name FROM bidders JOIN bids ON bidders.id = bids.bidder_id;

-- 5
WITH bid_count AS (SELECT count(id) AS bid_totals FROM bids GROUP BY bidder_id)
SELECT max(bid_totals) FROM bid_count;

SELECT max(count) FROM (SELECT count(id) FROM bids GROUP BY bidder_id) AS bid_count;

SELECT count(bidder_id) AS max FROM bids GROUP BY bidder_id ORDER BY max DESC LIMIT 1;

-- 6
SELECT name, (SELECT count(item_id)
FROM bids WHERE bids.item_id = items.id) FROM items;

SELECT items.name, count(bids.item_id) FROM items
  LEFT JOIN bids ON items.id = bids.item_id
  GROUP BY items.name;
  
-- 7
SELECT id FROM items
WHERE ROW(name, initial_price, sales_price) = ROW('Painting', 100.00, 250.00);

-- 8
-- With just EXPLAIN, the QUERY PLAN is presented with an estimate
-- of costs to execute the query (total 27.40) but the query isn't actually
-- executed
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- This does the same thing as EXPLAIN but also executes the query, so
-- the actual amount of time it takes is output as well
EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 9
EXPLAIN ANALYZE
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

------------------ subquery --- join
-- start up cost --- 1.97 ----- 1.78
-- total cost ------ 1.98 ----- 1.78
-- planning time --- 0.059 ---- 0.068
-- execution time -- 0.060 ---- 0.069
-- total time ------ 0.094 ---- 0.122

-- It is very close, but on average, the subquery is a little faster
-- it is interesting that the join has a lower cost on system resources
-- Also, I am using an old version of postgresql that only shows Total runtime
-- and not Planning time and Execution time separately.

EXPLAIN ANALYZE
SELECT name, (SELECT count(item_id)
FROM bids WHERE bids.item_id = items.id) FROM items;

EXPLAIN ANALYZE
SELECT items.name, count(bids.item_id) FROM items
  LEFT JOIN bids ON items.id = bids.item_id
  GROUP BY items.name;
  
------------------ subquery ------- join
-- start up cost --- 0.00 -------- 27.97
-- total cost ------ 1168.85 ----- 29.97
-- planning time --- 0.025 ------- 0.104
-- execution time -- 0.086 ------- 0.108
-- total time ------ 0.115 ------- 0.150

-- The scalar subquery is faster but supposedly takes way more system
-- resources