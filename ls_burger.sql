-- In PostgreSQL double quotes are used to indicate identifiers within the database, 
-- which are objects like tables, column names, and roles. In contrast, single 
-- quotes are used to indicate string literals.

CREATE TABLE orders (
    id integer,
    customer_name text,
    burger text,
    side text,
    drink text
);

INSERT INTO orders VALUES (1, 'Todd Perez', 'LS Burger', 'Fries', 'Lemonade');
INSERT INTO orders VALUES (2, 'Florence Jordan', 'LS Cheeseburger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (3, 'Robin Barnes', 'LS Burger', 'Onion Rings', 'Vanilla Shake');
INSERT INTO orders VALUES (4, 'Joyce Silva', 'LS Double Deluxe Burger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (5, 'Joyce Silva', 'LS Chicken Burger', 'Onion Rings', 'Cola');

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status) VALUES
('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
('Kakapo', 'Strigops habroptila', 4, 60, 'CR');

INSERT INTO orders (customer_name, customer_email, burger, burger_cost, side, side_cost, drink, drink_cost, customer_loyalty_points)
    VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 4.5, 'Fries', 0.99, 'Cola', 1.5, 28),
    ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 3.5, 'Fries', 0.99, NULL, DEFAULT, 18),
    ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 6, 'Onion Rings', 1.5, 'Chocolate Shake', 2, 42),
    ('Aaron Muller', NULL, 'LS Burger', 3, NULL, DEFAULT, NULL, DEFAULT, 10);
    
CREATE TABLE continents (
  id serial,
  continent_name varchar(100) NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE countries
  DROP COLUMN continent;
  
ALTER TABLE countries
  ADD COLUMN continent_id integer NOT NULL;
  
FOREIGN KEY (continent_id)

INSERT INTO continents (continent_name) VALUES
  ('Africa'),
  ('Asia'),
  ('Europe'),
  ('North America'),
  ('South America');
  
  id | continent_name 
----+----------------
  1 | Africa
  2 | Asia
  3 | Europe
  4 | North America
  5 | South America
  
INSERT INTO countries (name, capital, population, continent_id) VALUES
  ('Brazil', 'Brasilia',	208385000, 5),
  ('Egypt', 'Cairo',	96308900, 1),
  ('France', 'Paris', 67158000, 3),
  ('Germany', 'Berlin', 82349400,	3),
  ('Japan', 'Tokyo',	126672000,	2),
  ('USA', 'Washington D.C.', 325365189, 4);

Column     |          Type          |                         Modifiers                     
     
---------------+------------------------+------------------------------------------------------------
 id            | integer                | not null default nextval('famous_people_id_seq'::regclass)
 first_name    | character varying(80)  | not null
 occupation    | character varying(150) | 
 date_of_birth | date                   | not null
 deceased      | boolean                | not null default false
 last_name     | character varying(100) | 

CREATE TABLE albums (
  id serial,
  singer_id integer NOT NULL,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  PRIMARY KEY (id),
  FOREIGN KEY (singer_id) REFERENCES singers(id)
                          ON DELETE CASCADE
);

 id | first_name |             occupation              | date_of_birth | deceased |  last_name  
----+------------+-------------------------------------+---------------+----------+-------------
  3 | Frank      | Singer, Actor                       | 1915-12-12    | f        | Sinatra
  5 | Madonna    | Singer, Actress                     | 1958-08-16    | f        | 
  6 | Prince     | Singer, Songwriter, Musician, Actor | 1958-06-07    | t        | 
  8 | Elvis      | Singer, Musician, Actor             | 1935-01-08    | t        | Presley
  1 | Bruce      | Singer, Songwriter                  | 1949-09-23    | f        | Springsteen

INSERT INTO albums (album_name, released, genre, label, singer_id) VALUES
  ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
  ('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
  ('Born in the USA	', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
  ('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
  ('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
  ('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 8),
  ('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
  ('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 8);
  
  
id | customer_name  |         burger          |    side     |      drink      |     customer_email      | customer_loyalty_points | burger_cost | side_cost | drink_cost 
----+----------------+-------------------------+-------------+-----------------+-------------------------+-------------------------+-------------+-----------+------------
  7 | Natasha O'Shea | LS Double Deluxe Burger | Onion Rings | Chocolate Shake | natasha@osheafamily.com |                      42 |        6.00 |      1.50 |       2.00
  6 | Natasha O'Shea | LS Cheeseburger         | Fries       |                 | natasha@osheafamily.com |                      18 |        3.50 |      1.20 |       0.00
  5 | James Bergman  | LS Chicken Burger       | Fries       | Lemonade        | james1998@email.com     |                      28 |        4.50 |      1.20 |       1.50
  8 | Aaron Muller   | LS Burger               | Fries       |                 |                         |                      13 |        3.00 |      1.20 |       0.00
  
CREATE TABLE customers (
  id serial PRIMARY KEY,
  customer_name varchar(50) NOT NULL
);

CREATE TABLE email_addresses (
  customer_id int,
  customer_email varchar(50),
  PRIMARY KEY (customer_id),
  FOREIGN KEY (customer_id)
    REFERENCES customers (id)
    ON DELETE CASCADE
);

INSERT INTO customers (id, customer_name) VALUES
  (DEFAULT, 'James Bergman'),
  (DEFAULT, 'Natasha O''Shea'),
  (DEFAULT, 'Aaron Muller');
  
INSERT INTO email_addresses (customer_id, customer_email) VALUES
  (1, 'james1998@email.com'),
  (2, 'natasha@osheafamily.com'),
  (3, NULL);
  
CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost numeric(4,2),
  product_type varchar(20),
  product_loyalty_points int
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points) VALUES
  ('LS Burger',	3.00,	'Burger',	10),
  ('LS Cheeseburger',	3.50,	'Burger',	15),
  ('LS Chicken Burger',	4.50,	'Burger',	20),
  ('LS Double Deluxe Burger',	6.00,	'Burger',	30),
  ('Fries',	1.20,	'Side',	3),
  ('Onion Rings',	1.50,	'Side',	5),
  ('Cola',	1.50,	'Drink',	5),
  ('Lemonade',	1.50,	'Drink',	5),
  ('Vanilla Shake',	2.00,	'Drink',	7),
  ('Chocolate Shake',	2.00,	'Drink',	7),
  ('Strawberry Shake',	2.00,	'Drink',	7);
  
one customer can have many orders (one to many)
one order_item can have many products and one product can be in many order_items (many to many)

create table orders (
  id serial PRIMARY KEY,
  customer_id integer,
  order_status varchar(20),
    FOREIGN KEY (customer_id)
      REFERENCES customers(id)
      ON DELETE CASCADE
);

create table order_items (
  id serial PRIMARY KEY,
  orders_id integer,
  product_id integer,
  FOREIGN KEY (order_id) REFERENCES orders(id)
    ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE
);

insert into orders (customer_id, order_status) Values
(1, 'In Progress'),
(2, 'Placed'),
(2, 'Complete'),
(3, 'Placed');

INSERT INTO order_items (order_id, product_id) VALUES
  (1, 3),
  (1, 5),
  (1, 6),
  (1, 7),
  (2, 2),
  (2, 5),
  (2, 7),
  (3, 4),
  (3, 2),
  (3, 5),
  (3, 5),
  (3, 6),
  (3, 9),
  (3, 10),
  (4, 1),
  (4, 5);
  
SELECT countries.name, continents.continent_name
  FROM countries
  JOIN continents
  ON countries.continent_id = continents.id;
  
SELECT c.name, t.continent_name
  FROM countries c
  LEFT JOIN continents t
  ON c.continent_id = t.id;
  
Names and capitals of the European countries

If the continent is Europe, then return the names of the countries and the capitals

SELECT countries.name, countries.capital
  FROM countries
  JOIN continents
  ON countries.continent_id = continents.id
  WHERE continents.continent_name = 'Europe';
  
  
  
  WHERE countries.name IN (
    SELECT continent_name.continents
    FROM continents
    WHERE continent_name = "Europe"
  );
  
encyclopedia=# select * from singers;
 id | first_name |             occupation              | date_of_birth | deceased |  last_name  
----+------------+-------------------------------------+---------------+----------+-------------
  3 | Frank      | Singer, Actor                       | 1915-12-12    | f        | Sinatra
  5 | Madonna    | Singer, Actress                     | 1958-08-16    | f        | 
  6 | Prince     | Singer, Songwriter, Musician, Actor | 1958-06-07    | t        | 
  8 | Elvis      | Singer, Musician, Actor             | 1935-01-08    | t        | Presley
  1 | Bruce      | Singer, Songwriter                  | 1949-09-23    | f        | Springsteen
(5 rows)

encyclopedia=# select * from albums;
 id | singer_id |    album_name     |  released  |              genre              |           label           
----+-----------+-------------------+------------+---------------------------------+---------------------------
  1 |         1 | Born to Run       | 1975-08-25 | Rock and roll                   | Columbia
  2 |         6 | Purple Rain       | 1984-06-25 | Pop, R&B, Rock                  | Warner Bros
  3 |         1 | Born in the USA   | 1984-06-04 | Rock and roll, pop              | Columbia
  4 |         5 | Madonna           | 1983-07-27 | Dance-pop, post-disco           | Warner Bros
  5 |         5 | True Blue         | 1986-06-30 | Dance-pop, Pop                  | Warner Bros
  6 |         8 | Elvis             | 1956-10-19 | Rock and roll, Rhythm and Blues | RCA Victor
  7 |         6 | Sign o' the Times | 1987-03-30 | Pop, R&B, Rock, Funk            | Paisley Park, Warner Bros
  8 |         8 | G.I. Blues        | 1960-10-01 | Rock and roll, Pop              | RCA Victor
  
SELECT * FROM singers
  JOIN albums
  ON singers.id = albums.singer_id;

SELECT DISTINCT singers.first_name
  FROM singers JOIN albums
  ON singers.id = albums.singer_id
  WHERE label LIKE '%Warner Bros%';
  
SELECT s.first_name, s.last_name, a.album_name, a.released
  FROM singers s
  JOIN albums a
  ON s.id = a.singer_id
  WHERE s.deceased = false AND date_part('year', a.released) > 1979 AND date_part('year', a.released) < 1990
  ORDER BY s.date_of_birth DESC;
  
SELECT s.first_name, s.last_name
FROM singers s LEFT JOIN albums a
ON s.id = a.singer_id
WHERE a.singer_id IS NULL;

SELECT first_name, last_name FROM singers
  WHERE id NOT IN (SELECT singer_id FROM albums);
  
SELECT orders.*, products.*
FROM orders JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;

SELECT DISTINCT o.order_id
FROM order_items o JOIN products p
ON o.product_id = p.id
WHERE p.product_name = 'Fries';

SELECT DISTINCT c.customer_name AS "Customers who like Fries"
FROM customers c JOIN orders o
ON c.id = o.customer_id
JOIN order_items oi
ON o.id = oi.order_id
JOIN products p
ON oi.product_id = p.id
WHERE p.product_name = 'Fries';

SELECT sum(p.product_cost) AS "Total cost of Natasha O'Shea's Orders:"
FROM customers c JOIN orders o
ON c.id = o.customer_id
JOIN order_items oi
ON o.id = oi.order_id
JOIN products p
ON oi.product_id = p.id
WHERE c.customer_name = 'Natasha O''Shea';

SELECT *
FROM customers c JOIN orders o
ON c.id = o.customer_id
JOIN order_items oi
ON o.id = oi.order_id
JOIN products p
ON oi.product_id = p.id;

SELECT p.product_name, count(oi.product_id)
FROM order_items oi
JOIN products p
ON oi.product_id = p.id
GROUP BY p.product_name
ORDER BY p.product_name;