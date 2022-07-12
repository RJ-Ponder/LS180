-- 1
-- \i group_agg_file.sql

-- 2
INSERT INTO films (title, year, genre, director, duration) VALUES
  ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
  ('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);
  
-- 3
SELECT DISTINCT genre FROM films;

-- 4
SELECT genre FROM films GROUP BY genre;

-- 5
SELECT ROUND(AVG(duration)) FROM films;

-- 6
SELECT genre, ROUND(AVG(duration)) AS average_duration FROM films GROUP BY genre;

-- 7
SELECT (year / 10) * 10 AS decade, ROUND(AVG(duration)) AS average_duration
FROM films GROUP BY decade ORDER BY decade;
-- or by rounding the year down
SELECT ROUND(year, -1) as decade, ROUND(AVG(duration)) as average_duration
  FROM films GROUP BY decade ORDER BY decade;

-- 8
SELECT * FROM films WHERE director LIKE 'John %';

-- 9
SELECT genre, count(films.id) FROM films GROUP BY genre ORDER BY count DESC;

-- 10
SELECT year / 10 * 10 as decade, genre, string_agg(title, ', ')
FROM films GROUP BY decade, genre ORDER BY decade;

-- 11
SELECT genre, sum(duration) AS total_duration
FROM films GROUP BY genre ORDER BY total_duration, genre ASC;