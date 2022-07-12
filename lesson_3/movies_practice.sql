--1
-- \i lesson_3/movies.sql

--2
CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id integer NOT NULL REFERENCES directors (id),
  film_id integer NOT NULL REFERENCES films (id)
);

--3
INSERT INTO directors_films (director_id, film_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3), 
  (4, 4),
  (5, 5),
  (6, 6),
  (3, 7),
  (7, 8),
  (8, 9),
  (4, 10);
-- or using a shortcut:
INSERT INTO directors_films (director_id, film_id)
  SELECT director_id, id FROM films;

--4
ALTER TABLE films DROP COLUMN director_id;

--5
SELECT films.title, directors.name
FROM films
  JOIN directors_films ON films.id = directors_films.film_id
  JOIN directors ON directors_films.director_id = directors.id
ORDER BY films.title ASC;

--6
INSERT INTO directors (name) VALUES
  ('Joel Coen'),
  ('Ethan Coen'),
  ('Frank Miller'),
  ('Robert Rodriguez');
  
INSERT INTO films (title, year, genre, duration) VALUES
  ('Fargo', 1996, 'comedy', 98),
  ('No Country for Old Men', 2007, 'western', 122),
  ('Sin City', 2005, 'crime', 124),
  ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors_films (film_id, director_id) VALUES
  (11, 9),
  (12, 9),
  (12, 10),
  (13, 11),
  (13, 12),
  (14, 12);

--7
SELECT directors.name AS director, count(directors_films.film_id) AS films
	FROM directors JOIN directors_films ON directors.id = directors_films.director_id
	JOIN films ON directors_films.film_id = films.id
	GROUP BY directors.id
	ORDER BY films DESC, directors.name ASC;
