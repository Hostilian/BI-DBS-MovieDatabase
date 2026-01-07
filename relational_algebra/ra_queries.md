# Relational Algebra Expressions

This document contains all Relational Algebra (RA) expressions for the Movie Database queries.

## Notation

| Symbol | Meaning |
|--------|---------|
| π | Projection (select columns) |
| σ | Selection (filter rows) |
| ⋈ | Natural Join |
| ⟕ | Left Outer Join |
| ⟖ | Right Outer Join |
| ⟗ | Full Outer Join |
| × | Cartesian Product (Cross Join) |
| ∪ | Union |
| ∩ | Intersection |
| − | Difference |
| γ | Grouping/Aggregation |
| τ | Sorting (ORDER BY) |
| ρ | Rename |

---

## Query Expressions

### D1 - Basic Projection
**Natural:** Show only the title and year for every movie to build a compact catalog view.
```
π title, year (MOVIE)
```

### D2 - List Projection
**Natural:** List every movie title in the database.
```
π title (MOVIE)
```

### D3 - Set Difference (NOT IN)
**Natural:** Find movie IDs for films that have never received any awards.
```
π movie_id (MOVIE) − π movie_id (AWARD)
```

### D4 - Selection with Join
**Natural:** Return movies directed by Christopher Nolan.
```
π MOVIE.* (σ name='Christopher Nolan' (MOVIE ⋈ DIRECTOR))
```

### D5 - Universal Quantification (Division)
**Natural:** Find actors who have appeared in every genre.
```
π actor_id, movie_id (MOVIE_CAST ⋈ MOVIE_GENRE) ÷ π genre_id (GENRE)
```

### D6 - Nested Query Result
**Natural:** Show the names of actors from D5.
```
π name (ACTOR ⋈ [result_from_D5])
```

### D7 - Join with Year Filter
**Natural:** Show movies with their directors for films released after 2015.
```
π title, year, name (σ year > 2015 (MOVIE ⋈ DIRECTOR))
```

### D8 - Basic Inner Join
**Natural:** List movie titles together with director names.
```
π title, name (MOVIE ⋈ DIRECTOR)
```

### D9 - Join with Rating Filter
**Natural:** Display titles and director names only for movies rated above 8.0.
```
π title, name (σ imdb_rating > 8.0 (MOVIE ⋈ DIRECTOR))
```

### D10 - Join with Multiple Columns
**Natural:** Show director names alongside their movie titles and IMDb ratings.
```
π name, title, imdb_rating (MOVIE ⋈ DIRECTOR)
```

### D11 - Join Junction Table
**Natural:** Show each genre with the IDs of movies assigned to it.
```
π genre_id, movie_id, genre_name, created_at (GENRE ⋈ MOVIE_GENRE)
```

### D12 - Single Column Projection
**Natural:** List all IMDb ratings from the movie table.
```
π imdb_rating (MOVIE)
```

### D13 - Two Column Projection
**Natural:** List each movie with its director ID.
```
π movie_id, director_id (MOVIE)
```

### D14 - Three Column Projection
**Natural:** Show the ID, title, and release year of every movie.
```
π movie_id, title, year (MOVIE)
```

### D15 - UNION
**Natural:** Combine director and actor names.
```
π name (DIRECTOR) ∪ π name (ACTOR)
```

### D16 - INTERSECT
**Natural:** Find movie IDs that appear both in the movie table and in awards.
```
π movie_id (MOVIE) ∩ π movie_id (AWARD)
```

### D17 - EXCEPT (Set Difference)
**Natural:** Find directors who have not directed any movie yet.
```
π director_id (DIRECTOR) − π director_id (MOVIE)
```

### D18 - EXISTS (Semi-Join)
**Natural:** List all movies that have at least one award.
```
MOVIE ⋉ AWARD
```
Or equivalently:
```
π movie_id (MOVIE ⋈ AWARD)
```

### D19 - Join for Display
**Natural:** Show movie titles together with each award name they received.
```
π title, award_name, category (MOVIE ⋈ AWARD)
```

### D20 - Full Table
**Natural:** Show every column and row from the movie table.
```
MOVIE
```

### D21 - DISTINCT Years
**Natural:** List all distinct release years present in the movie table.
```
π year (MOVIE)
```

### D22 - Comparison Selection
**Natural:** Find movies with IMDb rating greater than 8.0.
```
σ imdb_rating > 8.0 (MOVIE)
```

### D23 - Simple Table Display
**Natural:** Show all studios with their country information.
```
STUDIO
```

### D24 - Multi-Column Projection
**Natural:** Display movie title, release year, IMDb rating, and runtime.
```
π title, year, imdb_rating, runtime (MOVIE)
```

### D25 - CROSS JOIN (Cartesian Product)
**Natural:** Generate every combination of genres and countries.
```
GENRE × COUNTRY
```

### D26 - LEFT JOIN
**Natural:** List all directors together with their movies.
```
DIRECTOR ⟕ MOVIE
```

### D27 - FULL OUTER JOIN
**Natural:** Show all movies and all awards including unmatched records.
```
MOVIE ⟗ AWARD
```

### D28 - Subquery with Aggregation
**Natural:** Find directors with their average movie rating.
```
DIRECTOR ⋈ (γ director_id, AVG(imdb_rating)→avg_rating (MOVIE))
```

### D29 - DISTINCT Multiple Columns
**Natural:** Select distinct movie ID and title pairs.
```
π movie_id, title (MOVIE)
```

### D30 - GROUP BY for Distinct
**Natural:** Group movies by their release year.
```
γ year (MOVIE)
```

### D31 - GROUP BY with COUNT
**Natural:** Count the number of movies released each year.
```
γ year, COUNT(*)→movie_count (MOVIE)
```

### D32 - ORDER BY
**Natural:** Order movies by year descending, then by rating descending.
```
τ year DESC, imdb_rating DESC (π movie_id, title, year, imdb_rating (MOVIE))
```

### D33 - CASE Expression
**Natural:** Categorize movies by their rating into quality tiers.
```
π title, imdb_rating, quality_tier (
    ρ quality_tier←CASE(...) (MOVIE)
)
```

### D34 - LIKE Pattern Matching
**Natural:** Find movies whose title contains 'the'.
```
σ title LIKE '%the%' (MOVIE)
```

### D35 - Date Functions
**Natural:** Extract year components from release dates.
```
π movie_id, title, release_date, EXTRACT(YEAR) (MOVIE)
```

### D36 - VIEW Query
**Natural:** Query the high_rated_movies view.
```
high_rated_movies
```
Where: `high_rated_movies := σ imdb_rating > 8.0 (MOVIE)`

### D37 - Subquery in SELECT
**Natural:** List movies and the count of awards they won.
```
π title, year, award_count (
    MOVIE ⋈ (γ movie_id, COUNT(*)→award_count (AWARD))
)
```

### D38 - INSERT (State After)
**Natural:** Show genres after inserting 'Documentary'.
```
GENRE
```

### D39 - UPDATE (Current State)
**Natural:** Show Dune after updating runtime.
```
σ title='Dune' (MOVIE)
```

### D40 - DELETE (Filtered)
**Natural:** Show user ratings that are lower than 2.
```
σ rating < 2 (USER_RATING)
```

### D41 - LEFT OUTER JOIN
**Natural:** List all movies with their award information.
```
MOVIE ⟕ AWARD
```

---

## Category Coverage Summary

| Category | Queries |
|----------|---------|
| A (JOIN) | D4, D5, D7-D11, D19, D27, D28, D37, D41 |
| B (NOT IN) | D3 |
| C (Two relations) | D4 |
| D1 (Projection) | D1, D5 |
| D2 (Nested selection) | D6 |
| F1 (Subquery FROM) | D5, D28 |
| F2 (INNER JOIN) | D4, D7-D11, D19, D37 |
| F3 (CROSS JOIN) | D25 |
| F4 (LEFT JOIN) | D41 |
| F5 (FULL JOIN) | D27 |
| G1 (EXISTS) | D5, D18 |
| G2 (Nested aggregate) | D28 |
| G4 (ALL) | D5 |
| H1 (UNION) | D15 |
| H2 (EXCEPT) | D3, D17 |
| H3 (INTERSECT) | D16 |
| I1 (GROUP BY) | D28, D31 |
| I2 (Aggregates) | D28, D31 |
| K (ORDER BY) | D32 |
| L (CASE) | D33 |
| M (Comparison) | D22 |
| N (LIKE) | D34 |
| O (Date functions) | D35 |
| P (VIEW) | D36 |
