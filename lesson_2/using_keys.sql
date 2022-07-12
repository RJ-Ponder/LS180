-- 1
CREATE SEQUENCE counter;

-- 2
SELECT nextval('counter');

-- 3
DROP SEQUENCE counter;

-- 4
CREATE SEQUENCE even_counter INCREMENT 2 MINVALUE 0 START 0;

-- 5
-- Default names are table_column_seq
-- regions_id_seq

-- 6
ALTER TABLE films
  ADD COLUMN id serial PRIMARY KEY;
  
-- 7
-- Duplicate value row error.
UPDATE films SET id = 1 WHERE title = 'The Birdcage';
-- ERROR:  duplicate key value violates unique constraint "films_pkey"
-- DETAIL:  Key (id)=(1) already exists.

-- 8
-- primary key exists
ALTER TABLE films
  ADD COLUMN id_2 serial PRIMARY KEY;
-- ERROR:  multiple primary keys for table "films" are not allowed

-- 9
ALTER TABLE films DROP CONSTRAINT films_pkey;