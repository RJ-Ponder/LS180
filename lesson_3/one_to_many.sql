-- import phone.sql

-- 1
INSERT INTO calls ("when", duration, contact_id) VALUES
  ('2016-01-18 14:47:00', 632, 6);
  
-- 2
SELECT calls.when, calls.duration, contacts.first_name FROM calls
  JOIN contacts ON calls.contact_id = contacts.id
  WHERE (contacts.first_name || ' ' || contacts.last_name) != 'William Swift';
-- the above assumes you don't know the id for William Swift and only the name

-- 3
INSERT INTO contacts (first_name, last_name, number) VALUES
  ('Merve', 'Elk', 6343511126),
  ('Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls ("when", duration, contact_id) VALUES
  ('2016-01-17 11:52:00', 175, 26),
  ('2016-01-18 21:22:00', 79, 27);
  
-- 4
ALTER TABLE contacts ADD UNIQUE (number);

-- 5
INSERT INTO contacts (first_name, last_name, number) VALUES
  ('Bob', 'Smith', 7204890809);
  
-- ERROR:  duplicate key value violates unique constraint "contacts_number_key"
-- DETAIL:  Key (number)=(7204890809) already exists.

-- 6
-- when is a reserved word and can't be used as an identifier, so use quotes

-- 7
-- draw an ERD for this data
-- I drew the physical level, but the question was asking for conceptual

-- conceptual: one contact can have zero or many calls (cardinality many, modality 0)

-- calls
-- id integer, not null, default next value, primary key
-- when timestamp, not null
-- duration integer, not null
-- contact_id integer, not null, foreign key references contacts primary key

-- contacts
-- id, integer, not null, default next value, primary key referenced by calls
-- first_name, text, not null
-- last_name, text, not null
-- number, character varying, not null, unique