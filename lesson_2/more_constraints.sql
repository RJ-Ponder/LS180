-- 1
-- import via psql -d database < file.sql

-- 2
ALTER TABLE films
  ALTER COLUMN title SET NOT NULL,
  ALTER COLUMN year SET NOT NULL,
  ALTER COLUMN genre SET NOT NULL,
  ALTER COLUMN director SET NOT NULL,
  ALTER COLUMN duration SET NOT NULL;
  
-- 3
-- The modifier not null is added

-- 4
-- the parenthesis around the column is important. Allows you to add more columns if needed
ALTER TABLE films
  ADD CONSTRAINT unique_title UNIQUE (title); -- unique_title custom name given

ALTER TABLE films
  ADD UNIQUE (title); -- a default name will be given films_title_key
  
-- 5
-- The constraint is displayed as an index at the bottom
-- "constraint_name" UNIQUE CONSTRAINT, btree (title)
-- the btree is the algorithm for how the constraint is carried out
-- only default and not null are column constraints (modifiers)
-- all other constraints (primary key, foreign key, unique, check) are table constraints

-- 6
ALTER TABLE films
  DROP CONSTRAINT films_title_key;
  
-- 7
ALTER TABLE films
  ADD CONSTRAINT title_length
  CHECK (length(title) >= 1); -- again, parenthesis are important
  
-- 8
-- new row for relation "films" violates check constraint "title_length"
INSERT INTO films VALUES ('', 1950, 'action', 'Bob', 120);

-- 9
-- it is displayed as a check constraint below the table

-- 10
ALTER TABLE films DROP CONSTRAINT title_length;

-- 11
ALTER TABLE films ADD CHECK (year BETWEEN 1900 AND 2100); -- default name

ALTER TABLE films ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100); -- custom name

-- 12
-- Added as a check constraint

-- 13
ALTER TABLE films ADD CONSTRAINT director_requirements
CHECK (length(director) >= 3 AND director LIKE ' %');
-- or
ALTER TABLE films ADD CONSTRAINT director_name
    CHECK (length(director) >= 3 AND position(' ' in director) > 0);
-- where position returns the character number starting with 1
-- of the first instance of the search string in the main string or 0 if not found

-- 14
-- As a check constraint

-- 15
UPDATE films
SET director = 'Johnny'
WHERE title = 'Die Hard';
-- ERROR:  new row for relation "films" violates check constraint "director_name"
-- DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).

-- 16
-- 1) data type
-- 2) table constraint (primary key, foreign key, unique, check)
-- 3) column constraint (default, not null)

-- 17
CREATE TABLE conflict (
id serial,
name text
);

ALTER TABLE conflict ADD CHECK (length(name) > 0);
ALTER TABLE conflict ALTER COLUMN name SET DEFAULT '';

-- You can create a table with conflicting constraints and/or defaults, but
-- you won't be able to add any data. If existing data conflicts with the
-- constraints you won't be able to add the constraint.

-- 18
-- use the meta command \d TABLE_NAME