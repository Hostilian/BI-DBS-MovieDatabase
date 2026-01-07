# Database Schema Documentation

## Overview

The Movie Database schema consists of 10 tables designed to store comprehensive information about movies, their creators, and user interactions.

## Entity-Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         MOVIE DATABASE ER DIAGRAM                           │
└─────────────────────────────────────────────────────────────────────────────┘

    ┌─────────────┐                    ┌─────────────┐
    │   COUNTRY   │                    │   STUDIO    │
    ├─────────────┤                    ├─────────────┤
    │*country_id  │◄───────────────────│ country_id  │
    │ country_name│         1:N        │*studio_id   │◄──┐
    │ country_code│                    │ studio_name │   │
    │ created_at  │                    │ founded_year│   │
    └─────────────┘                    │ created_at  │   │
                                       └─────────────┘   │
                                                         │
    ┌─────────────┐                                      │
    │  DIRECTOR   │                                      │
    ├─────────────┤                                      │
    │*director_id │◄──┐                                  │
    │ name        │   │                                  │
    │ birth_year  │   │                                  │
    │ created_at  │   │                                  │
    └─────────────┘   │                                  │
                      │ 1:N                              │ 1:N
                      │                                  │
                      │    ┌─────────────────────┐       │
                      │    │       MOVIE         │       │
                      │    ├─────────────────────┤       │
                      └────│ director_id         │       │
                           │*movie_id            │───────┘
                           │ imdb_id             │
                           │ title               │
                           │ year                │
                           │ runtime             │
                           │ imdb_rating         │
                           │ imdb_votes          │
                           │ plot                │
                           │ box_office          │
                           │ release_date        │
                           │ studio_id           │
                           │ sequel_of           │──┐ (self-reference)
                           │ created_at          │◄─┘
                           └──────────┬──────────┘
                                      │
           ┌──────────────────────────┼──────────────────────────┐
           │                          │                          │
           │ N:M                      │ 1:N                      │ N:M
           ▼                          ▼                          ▼
    ┌─────────────┐          ┌─────────────┐          ┌─────────────┐
    │ MOVIE_GENRE │          │    AWARD    │          │ MOVIE_CAST  │
    ├─────────────┤          ├─────────────┤          ├─────────────┤
    │*movie_id    │          │*award_id    │          │*movie_id    │
    │*genre_id    │          │ award_name  │          │*actor_id    │
    └──────┬──────┘          │ category    │          │ role        │
           │                 │ year_awarded│          │ billing_order│
           │ N:M             │ movie_id    │          └──────┬──────┘
           ▼                 │ is_winner   │                 │
    ┌─────────────┐          │ created_at  │                 │ N:M
    │    GENRE    │          └─────────────┘                 ▼
    ├─────────────┤                                   ┌─────────────┐
    │*genre_id    │                                   │    ACTOR    │
    │ genre_name  │          ┌─────────────┐          ├─────────────┤
    │ created_at  │          │ USER_RATING │          │*actor_id    │
    └─────────────┘          ├─────────────┤          │ name        │
                             │*rating_id   │          │ birth_year  │
                             │ movie_id    │──────────│ created_at  │
                             │ user_id     │   1:N    └─────────────┘
                             │ rating      │
                             │ review      │
                             │ review_date │
                             └─────────────┘
```

## Table Descriptions

### COUNTRY
Stores country information used for studio locations.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| country_id | SERIAL | PRIMARY KEY | Unique identifier |
| country_name | VARCHAR(100) | NOT NULL | Full country name |
| country_code | CHAR(2) | NOT NULL, UNIQUE | ISO 3166-1 alpha-2 code |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### GENRE
Movie genre classifications.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| genre_id | SERIAL | PRIMARY KEY | Unique identifier |
| genre_name | VARCHAR(50) | NOT NULL, UNIQUE | Genre name |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

**Sample Genres:** Action, Adventure, Sci-Fi, Drama, Thriller, Comedy, Romance, Horror, Fantasy, Crime, Animation

### DIRECTOR
Film directors information.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| director_id | SERIAL | PRIMARY KEY | Unique identifier |
| name | VARCHAR(100) | NOT NULL | Director's full name |
| birth_year | INTEGER | CHECK (1850-current) | Year of birth |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### ACTOR
Actors and actresses.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| actor_id | SERIAL | PRIMARY KEY | Unique identifier |
| name | VARCHAR(100) | NOT NULL | Actor's full name |
| birth_year | INTEGER | CHECK (1850-current) | Year of birth |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### STUDIO
Production studios and companies.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| studio_id | SERIAL | PRIMARY KEY | Unique identifier |
| studio_name | VARCHAR(100) | NOT NULL | Studio name |
| founded_year | INTEGER | CHECK (> 1880) | Year founded |
| country_id | INTEGER | FOREIGN KEY | Reference to COUNTRY |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### MOVIE
Core movie information - the central table.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| movie_id | SERIAL | PRIMARY KEY | Unique identifier |
| imdb_id | VARCHAR(20) | UNIQUE | IMDb identifier (tt...) |
| title | VARCHAR(200) | NOT NULL | Movie title |
| year | INTEGER | NOT NULL, CHECK | Release year |
| runtime | INTEGER | CHECK (> 0) | Duration in minutes |
| imdb_rating | DECIMAL(3,1) | CHECK (0-10) | IMDb rating |
| imdb_votes | INTEGER | DEFAULT 0 | Number of IMDb votes |
| plot | TEXT | | Movie synopsis |
| box_office | VARCHAR(50) | | Box office revenue |
| release_date | DATE | | Official release date |
| director_id | INTEGER | FOREIGN KEY | Reference to DIRECTOR |
| studio_id | INTEGER | FOREIGN KEY | Reference to STUDIO |
| sequel_of | INTEGER | FOREIGN KEY (self) | Reference to prequel |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### MOVIE_GENRE (Junction Table)
Many-to-many relationship between movies and genres.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| movie_id | INTEGER | PRIMARY KEY, FK | Reference to MOVIE |
| genre_id | INTEGER | PRIMARY KEY, FK | Reference to GENRE |

### MOVIE_CAST (Junction Table)
Many-to-many relationship between movies and actors.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| movie_id | INTEGER | PRIMARY KEY, FK | Reference to MOVIE |
| actor_id | INTEGER | PRIMARY KEY, FK | Reference to ACTOR |
| role | VARCHAR(100) | | Character name |
| billing_order | INTEGER | | Cast order |

### AWARD
Movie awards and nominations.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| award_id | SERIAL | PRIMARY KEY | Unique identifier |
| award_name | VARCHAR(100) | NOT NULL | Award name (Oscar, etc.) |
| category | VARCHAR(100) | NOT NULL | Award category |
| year_awarded | INTEGER | NOT NULL | Year of ceremony |
| movie_id | INTEGER | FOREIGN KEY | Reference to MOVIE |
| is_winner | BOOLEAN | DEFAULT FALSE | Won or nominated |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation time |

### USER_RATING
User-submitted ratings and reviews.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| rating_id | SERIAL | PRIMARY KEY | Unique identifier |
| movie_id | INTEGER | FOREIGN KEY | Reference to MOVIE |
| user_id | INTEGER | NOT NULL | User identifier |
| rating | DECIMAL(2,1) | CHECK (1-10) | User rating |
| review | TEXT | | Review text |
| review_date | TIMESTAMP | DEFAULT NOW() | Review submission time |

## Relationships Summary

| Relationship | Type | Description |
|--------------|------|-------------|
| COUNTRY → STUDIO | 1:N | One country has many studios |
| DIRECTOR → MOVIE | 1:N | One director makes many movies |
| STUDIO → MOVIE | 1:N | One studio produces many movies |
| MOVIE → MOVIE | 1:N | Self-reference for sequels |
| MOVIE ↔ GENRE | N:M | Movies can have multiple genres |
| MOVIE ↔ ACTOR | N:M | Movies have many actors, actors in many movies |
| MOVIE → AWARD | 1:N | One movie can win multiple awards |
| MOVIE → USER_RATING | 1:N | One movie has many user ratings |

## Indexes

Performance-optimized indexes are created on:
- `MOVIE(year)` - Filter by release year
- `MOVIE(imdb_rating)` - Filter by rating
- `MOVIE(director_id)` - Join with directors
- `MOVIE(studio_id)` - Join with studios
- `AWARD(movie_id)` - Join with movies
- `USER_RATING(movie_id)` - Join with movies
- `MOVIE_CAST(actor_id)` - Join with actors
- `MOVIE_GENRE(genre_id)` - Join with genres

## Views

### high_rated_movies
Movies with IMDb rating above 8.0.

```sql
CREATE VIEW high_rated_movies AS
SELECT movie_id, title, year, imdb_rating
FROM MOVIE
WHERE imdb_rating > 8.0
ORDER BY imdb_rating DESC;
```

### movie_summary
Comprehensive movie view with director and studio information.

```sql
CREATE VIEW movie_summary AS
SELECT 
    m.movie_id, m.title, m.year, m.imdb_rating,
    d.name AS director_name,
    s.studio_name
FROM MOVIE m
LEFT JOIN DIRECTOR d ON m.director_id = d.director_id
LEFT JOIN STUDIO s ON m.studio_id = s.studio_id;
```
