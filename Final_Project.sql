/* ερωτημα 1*/
SELECT YEAR(CAST(m.release_date AS DATE)) AS year, COUNT(m.title) AS movies_per_year
FROM movie m
WHERE m.budget > 1000000
GROUP BY YEAR(CAST(m.release_date AS DATE))
ORDER BY YEAR(CAST(m.release_date AS DATE));

/*ερωτημα 2*/
SELECT  g.name, COUNT(m.title) AS movies_per_genre
FROM movie m
INNER JOIN hasGenre hG
ON m.id = hG.movie_id
INNER JOIN genre g 
ON hG.genre_id = g.id
WHERE m.budget > 1000000 OR m.runtime >120
GROUP BY g.name;

/*ερωτημα 3*/
SELECT g.name, COUNT(m.title) AS movies_per_gy, YEAR(m.release_date) AS year
FROM movie m
INNER JOIN hasGenre hG
ON m.id = hG.movie_id
INNER JOIN genre g 
ON hG.genre_id = g.id
GROUP BY g.name, YEAR(m.release_date)
ORDER BY g.name, YEAR(m.release_date);

/*ερωτημα 4*/
SELECT YEAR(CAST(m.release_date AS DATE)) AS year, SUM(m.revenue) AS revenues_per_year
FROM movie m 
INNER JOIN movie_cast mc 
ON m.id = mc.movie_id 
WHERE mc.name = 'Antonio Banderas'
GROUP BY YEAR(CAST(m.release_date AS DATE));

/*ερωτημα 5*/
SELECT YEAR(m.release_date) AS year, MAX(m.budget) AS max_budget
FROM movie m
WHERE m.budget != 0
GROUP BY YEAR(m.release_date)
ORDER BY YEAR(m.release_date);

/*ερωτημα 6*/
SELECT c.name AS trilogy_name
FROM collection c
INNER JOIN belongsTocollection bc
ON c.id = bc.collection_id
GROUP BY c.name
HAVING  COUNT(bc.movie_id) = 3;

/*ερωτημα 7*/
SELECT r.user_id, AVG(r.rating) as avg_rating, COUNT(r.rating) AS rating_count
FROM ratings r
GROUP BY r.user_id;

/*ερωτημα 8*/
SELECT TOP 10 m.title, m.budget
FROM movie m 
ORDER BY m.budget DESC;

/*ερωτημα 9*/
SELECT erwthma5.year, m.title AS movie_with_max_budget
FROM (
  SELECT YEAR(m.release_date) AS year, MAX(m.budget) AS max_budget
  FROM movie m
  WHERE m.budget != 0
  GROUP BY YEAR(m.release_date)
) erwthma5
JOIN movie m ON YEAR(m.release_date) = erwthma5.year AND m.budget = erwthma5.max_budget
ORDER BY erwthma5.year, m.title;

/*ερωτημα 10*/

CREATE VIEW Popular_Movie_Pairs AS
SELECT m1.title AS movie1, m2.title AS movie2, COUNT(DISTINCT r1.user_id) AS popularity
FROM movie m1
INNER JOIN ratings r1 ON m1.id = r1.movie_id
INNER JOIN ratings r2 ON r1.user_id = r2.user_id AND r1.movie_id <> r2.movie_id
INNER JOIN movie m2 ON r2.movie_id = m2.id
WHERE r1.rating > 4 AND r2.rating > 4
GROUP BY m1.title, m2.title
HAVING COUNT(DISTINCT r1.user_id) > 10;

SELECT movie1, movie2, popularity
FROM Popular_Movie_Pairs
ORDER BY popularity;
