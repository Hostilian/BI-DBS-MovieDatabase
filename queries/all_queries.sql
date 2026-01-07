-- ============================================================================
-- BI-DBS Movie Database - All 41 SQL Queries
-- Course: BI-DBS.21 DBS-2025
-- Author: xozte001
--
-- This file contains all SQL queries organized by category
-- Each query includes: Natural language description, Category, SQL, and RA
-- ============================================================================

-- ============================================================================
-- D1 - Basic Projection (Category: D1)
-- Natural: Show only the title and year for every movie to build a compact catalog view.
-- ============================================================================
-- Relational Algebra: π title, year (MOVIE)
SELECT title, year FROM MOVIE;

-- ============================================================================
-- D2 - List Projection
-- Natural: List every movie title in the database to produce an alphabetical film list.
-- ============================================================================
-- Relational Algebra: π title (MOVIE)
SELECT title FROM MOVIE ORDER BY title;

-- ============================================================================
-- D3 - NOT IN / Set Difference (Category: B, H2)
-- Natural: Find movie IDs for films that have never received any awards.
-- ============================================================================
-- Relational Algebra: π movie_id (MOVIE) - π movie_id (AWARD)
SELECT movie_id FROM MOVIE
WHERE movie_id NOT IN (SELECT movie_id FROM AWARD WHERE movie_id IS NOT NULL);

-- ============================================================================
-- D4 - Two Relations with Selection (Category: A, C, F2)
-- Natural: Return movies directed by Christopher Nolan.
-- ============================================================================
-- Relational Algebra: π MOVIE.* (σ name='Christopher Nolan' (MOVIE ⋈ DIRECTOR))
SELECT m.*
FROM MOVIE m
JOIN DIRECTOR d ON m.director_id = d.director_id
WHERE d.name = 'Christopher Nolan';

-- ============================================================================
-- D5 - Universal Quantification (Category: A, D1, F1, G1, G4)
-- Natural: Find actors who have appeared in every genre.
-- ============================================================================
-- Relational Algebra: Uses division operation
SELECT a.actor_id, a.name
FROM ACTOR a
WHERE NOT EXISTS (
    SELECT g.genre_id FROM GENRE g
    WHERE NOT EXISTS (
        SELECT 1 FROM MOVIE_CAST mc
        JOIN MOVIE_GENRE mg ON mc.movie_id = mg.movie_id
        WHERE mc.actor_id = a.actor_id AND mg.genre_id = g.genre_id
    )
);

-- ============================================================================
-- D6 - Nested Query Result (Category: D2)
-- Natural: Show the names of actors found in the previous query (D5) to verify results.
-- ============================================================================
-- Relational Algebra: ACTOR - result from D5 lookup
SELECT * FROM ACTOR
WHERE actor_id IN (
    SELECT a.actor_id
    FROM ACTOR a
    WHERE NOT EXISTS (
        SELECT g.genre_id FROM GENRE g
        WHERE NOT EXISTS (
            SELECT 1 FROM MOVIE_CAST mc
            JOIN MOVIE_GENRE mg ON mc.movie_id = mg.movie_id
            WHERE mc.actor_id = a.actor_id AND mg.genre_id = g.genre_id
        )
    )
);

-- ============================================================================
-- D7 - Join with Selection (Category: A, F2)
-- Natural: Show movies with their directors, keeping only films released after 2015.
-- ============================================================================
-- Relational Algebra: σ year > 2015 (MOVIE ⋈ DIRECTOR)
SELECT m.title, m.year, d.name AS director_name
FROM MOVIE m
JOIN DIRECTOR d ON m.director_id = d.director_id
WHERE m.year > 2015;

-- ============================================================================
-- D8 - Basic Inner Join (Category: A, F2)
-- Natural: List movie titles together with director names.
-- ============================================================================
-- Relational Algebra: π title, name (MOVIE ⋈ DIRECTOR)
SELECT m.title, d.name AS director_name
FROM MOVIE m
JOIN DIRECTOR d ON m.director_id = d.director_id;

-- ============================================================================
-- D9 - Join with Condition (Category: A, F2)
-- Natural: Display titles and director names only for movies rated above 8.0.
-- ============================================================================
-- Relational Algebra: π title, name (σ imdb_rating > 8.0 (MOVIE ⋈ DIRECTOR))
SELECT m.title, d.name AS director_name
FROM MOVIE m
JOIN DIRECTOR d ON m.director_id = d.director_id
WHERE m.imdb_rating > 8.0;

-- ============================================================================
-- D10 - Join with Multiple Columns (Category: A, F2)
-- Natural: Show director names alongside their movie titles and IMDb ratings.
-- ============================================================================
-- Relational Algebra: π name, title, imdb_rating (MOVIE ⋈ DIRECTOR)
SELECT d.name AS director_name, m.title, m.imdb_rating
FROM MOVIE m
JOIN DIRECTOR d ON m.director_id = d.director_id;

-- ============================================================================
-- D11 - Join Junction Table (Category: A, F2)
-- Natural: Show each genre with the IDs of movies assigned to it.
-- ============================================================================
-- Relational Algebra: GENRE ⋈ MOVIE_GENRE
SELECT g.genre_id, mg.movie_id, g.genre_name, g.created_at
FROM GENRE g
JOIN MOVIE_GENRE mg ON g.genre_id = mg.genre_id;

-- ============================================================================
-- D12 - Single Column Projection
-- Natural: List all IMDb ratings from the movie table.
-- ============================================================================
-- Relational Algebra: π imdb_rating (MOVIE)
SELECT DISTINCT imdb_rating FROM MOVIE ORDER BY imdb_rating;

-- ============================================================================
-- D13 - Two Column Projection
-- Natural: List each movie with its director ID.
-- ============================================================================
-- Relational Algebra: π movie_id, director_id (MOVIE)
SELECT movie_id, director_id FROM MOVIE;

-- ============================================================================
-- D14 - Three Column Projection
-- Natural: Show the ID, title, and release year of every movie.
-- ============================================================================
-- Relational Algebra: π movie_id, title, year (MOVIE)
SELECT movie_id, title, year FROM MOVIE;

-- ============================================================================
-- D15 - UNION (Category: H1)
-- Natural: Combine director and actor names.
-- ============================================================================
-- Relational Algebra: π name (DIRECTOR) ∪ π name (ACTOR)
SELECT name FROM DIRECTOR
UNION
SELECT name FROM ACTOR
ORDER BY name;

-- ============================================================================
-- D16 - INTERSECT (Category: H3)
-- Natural: Find movie IDs that appear both in the movie table and in awards.
-- ============================================================================
-- Relational Algebra: π movie_id (MOVIE) ∩ π movie_id (AWARD)
SELECT movie_id FROM MOVIE
INTERSECT
SELECT movie_id FROM AWARD;

-- ============================================================================
-- D17 - EXCEPT / Set Difference (Category: H2)
-- Natural: Find directors who have not directed any movie yet.
-- ============================================================================
-- Relational Algebra: π director_id (DIRECTOR) - π director_id (MOVIE)
SELECT director_id FROM DIRECTOR
EXCEPT
SELECT director_id FROM MOVIE;

-- ============================================================================
-- D18 - EXISTS (Category: G1)
-- Natural: List all movies that have at least one award.
-- ============================================================================
-- Relational Algebra: σ EXISTS award (MOVIE)
SELECT movie_id FROM MOVIE m
WHERE EXISTS (SELECT 1 FROM AWARD a WHERE a.movie_id = m.movie_id);

-- ============================================================================
-- D19 - Join Two Tables for Display (Category: A, F2)
-- Natural: Show movie titles together with each award name they received.
-- ============================================================================
-- Relational Algebra: π title, award_name (MOVIE ⋈ AWARD)
SELECT m.title, a.award_name, a.category
FROM MOVIE m
JOIN AWARD a ON m.movie_id = a.movie_id;

-- ============================================================================
-- D20 - Full Table Scan
-- Natural: Show every column and row from the movie table.
-- ============================================================================
-- Relational Algebra: MOVIE
SELECT * FROM MOVIE;

-- ============================================================================
-- D21 - DISTINCT Projection
-- Natural: List all distinct release years present in the movie table.
-- ============================================================================
-- Relational Algebra: π year (MOVIE)
SELECT DISTINCT year FROM MOVIE ORDER BY year;

-- ============================================================================
-- D22 - Comparison Operators (Category: M)
-- Natural: Find movies with IMDb rating greater than 8.0.
-- ============================================================================
-- Relational Algebra: σ imdb_rating > 8.0 (MOVIE)
SELECT * FROM MOVIE WHERE imdb_rating > 8.0;

-- ============================================================================
-- D23 - Simple Table Display
-- Natural: Show all studios with their country information.
-- ============================================================================
-- Relational Algebra: STUDIO
SELECT * FROM STUDIO;

-- ============================================================================
-- D24 - Multi-Column Projection
-- Natural: Display movie title, release year, IMDb rating, and runtime.
-- ============================================================================
-- Relational Algebra: π title, year, imdb_rating, runtime (MOVIE)
SELECT title, year, imdb_rating, runtime FROM MOVIE;

-- ============================================================================
-- D25 - CROSS JOIN / Cartesian Product (Category: F3)
-- Natural: Generate every combination of genres and countries.
-- ============================================================================
-- Relational Algebra: GENRE × COUNTRY
SELECT * FROM GENRE CROSS JOIN COUNTRY;

-- ============================================================================
-- D26 - LEFT JOIN Including NULLs
-- Natural: List all directors together with their movies, including directors who have no films yet.
-- ============================================================================
-- Relational Algebra: DIRECTOR ⟕ MOVIE
SELECT d.*
FROM DIRECTOR d
LEFT JOIN MOVIE m ON d.director_id = m.director_id;

-- ============================================================================
-- D27 - FULL OUTER JOIN (Category: A, F5)
-- Natural: Show all movies and all awards including unmatched records from both sides.
-- ============================================================================
-- Relational Algebra: MOVIE ⟗ AWARD
SELECT *
FROM MOVIE m
FULL OUTER JOIN AWARD a ON m.movie_id = a.movie_id;

-- ============================================================================
-- D28 - Subquery in FROM with Aggregation (Category: A, F1, G2, I1, I2)
-- Natural: Find directors with their average movie rating using a subquery in the FROM clause.
-- ============================================================================
-- Relational Algebra: DIRECTOR ⋈ (γ director_id, AVG(imdb_rating) (MOVIE))
SELECT d.name, sub.avg_rating
FROM DIRECTOR d
JOIN (
    SELECT director_id, AVG(imdb_rating) as avg_rating
    FROM MOVIE
    GROUP BY director_id
) sub ON d.director_id = sub.director_id
ORDER BY sub.avg_rating DESC;

-- ============================================================================
-- D29 - DISTINCT with Multiple Columns
-- Natural: Select distinct movie ID and title pairs.
-- ============================================================================
-- Relational Algebra: π movie_id, title (MOVIE)
SELECT DISTINCT movie_id, title FROM MOVIE;

-- ============================================================================
-- D30 - GROUP BY for Distinct Values
-- Natural: Group movies by their release year to see which years have films.
-- ============================================================================
-- Relational Algebra: γ year (MOVIE)
SELECT year FROM MOVIE GROUP BY year ORDER BY year;

-- ============================================================================
-- D31 - GROUP BY with COUNT (Category: I1, I2)
-- Natural: Count the number of movies released each year using GROUP BY with aggregate.
-- ============================================================================
-- Relational Algebra: γ year, COUNT(*) (MOVIE)
SELECT year, COUNT(*) as movie_count
FROM MOVIE
GROUP BY year
ORDER BY movie_count DESC, year DESC;

-- ============================================================================
-- D32 - ORDER BY Multiple Columns (Category: K)
-- Natural: Order movies first by year descending, then by rating descending to find best recent films.
-- ============================================================================
-- Relational Algebra: τ year DESC, imdb_rating DESC (π movie_id, title, year, imdb_rating (MOVIE))
SELECT movie_id, title, year, imdb_rating
FROM MOVIE
ORDER BY year DESC, imdb_rating DESC;

-- ============================================================================
-- D33 - CASE Expression (Category: L)
-- Natural: Categorize movies by their rating into quality tiers using CASE expression.
-- ============================================================================
SELECT
    title,
    imdb_rating,
    CASE
        WHEN imdb_rating >= 9.0 THEN 'Masterpiece'
        WHEN imdb_rating >= 8.0 THEN 'Excellent'
        WHEN imdb_rating >= 7.0 THEN 'Good'
        ELSE 'Average'
    END as quality_tier
FROM MOVIE;

-- ============================================================================
-- D34 - LIKE Pattern Matching (Category: N)
-- Natural: Find movies whose title contains a specific word using string pattern matching with LIKE.
-- ============================================================================
-- Relational Algebra: σ title LIKE '%the%' (MOVIE)
SELECT movie_id, title
FROM MOVIE
WHERE title LIKE '%the%' OR title LIKE '%The%';

-- ============================================================================
-- D35 - Date Functions (Category: O)
-- Natural: Calculate movie age and extract year components from release dates using date functions.
-- ============================================================================
SELECT
    movie_id,
    title,
    release_date,
    EXTRACT(YEAR FROM release_date) as release_year,
    CURRENT_DATE - release_date as days_since_release
FROM MOVIE;

-- ============================================================================
-- D36 - Query VIEW (Category: P)
-- Natural: Query the high_rated_movies view to find critically acclaimed films with rating above 8.
-- ============================================================================
-- Relational Algebra: high_rated_movies view
SELECT * FROM high_rated_movies;

-- ============================================================================
-- D37 - Subquery in SELECT (Category: A, F2)
-- Natural: List movies and the count of awards they won using a subquery in the SELECT clause.
-- ============================================================================
SELECT
    m.title,
    m.year,
    (SELECT COUNT(*) FROM AWARD a WHERE a.movie_id = m.movie_id) as award_count
FROM MOVIE m
ORDER BY award_count DESC;

-- ============================================================================
-- D38 - INSERT Statement Demo
-- Natural: Insert a new genre named 'Documentary'.
-- ============================================================================
-- Note: This shows the result after insertion
-- INSERT INTO GENRE (genre_name) VALUES ('Documentary');
SELECT * FROM GENRE ORDER BY genre_id;

-- ============================================================================
-- D39 - UPDATE Statement Demo
-- Natural: Update the runtime of 'Dune' to 156 minutes.
-- ============================================================================
-- Note: This shows the current state
-- UPDATE MOVIE SET runtime = 156 WHERE title = 'Dune';
SELECT * FROM MOVIE WHERE title = 'Dune';

-- ============================================================================
-- D40 - DELETE Statement Demo
-- Natural: Delete user ratings that are lower than 2.
-- ============================================================================
-- Note: This shows ratings that would be deleted
-- DELETE FROM USER_RATING WHERE rating < 2;
SELECT * FROM USER_RATING WHERE rating < 2;

-- ============================================================================
-- D41 - LEFT OUTER JOIN (Category: A, F4)
-- Natural: List all movies with their award information, keeping rows for movies that have never won.
-- ============================================================================
-- Relational Algebra: MOVIE ⟕ AWARD
SELECT *
FROM MOVIE m
LEFT OUTER JOIN AWARD a ON m.movie_id = a.movie_id;

-- ============================================================================
-- End of Query File
-- ============================================================================
