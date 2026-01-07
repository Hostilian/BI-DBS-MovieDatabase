-- ============================================================================
-- BI-DBS Movie Database - Schema Creation Script
-- Course: BI-DBS.21 DBS-2025
-- Author: xozte001
-- ============================================================================

-- Drop tables if they exist (in correct order due to foreign keys)
DROP TABLE IF EXISTS USER_RATING CASCADE;
DROP TABLE IF EXISTS AWARD CASCADE;
DROP TABLE IF EXISTS MOVIE_CAST CASCADE;
DROP TABLE IF EXISTS MOVIE_GENRE CASCADE;
DROP TABLE IF EXISTS MOVIE CASCADE;
DROP TABLE IF EXISTS ACTOR CASCADE;
DROP TABLE IF EXISTS DIRECTOR CASCADE;
DROP TABLE IF EXISTS GENRE CASCADE;
DROP TABLE IF EXISTS STUDIO CASCADE;
DROP TABLE IF EXISTS COUNTRY CASCADE;

-- ============================================================================
-- COUNTRY Table
-- Stores country information for studios and actors
-- ============================================================================
CREATE TABLE COUNTRY (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE COUNTRY IS 'Stores country information for studios and international classification';
COMMENT ON COLUMN COUNTRY.country_code IS 'ISO 3166-1 alpha-2 country code';

-- ============================================================================
-- GENRE Table
-- Movie genre classifications
-- ============================================================================
CREATE TABLE GENRE (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE GENRE IS 'Movie genre classifications (Action, Drama, Comedy, etc.)';

-- ============================================================================
-- DIRECTOR Table
-- Film directors information
-- ============================================================================
CREATE TABLE DIRECTOR (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER CHECK (birth_year > 1850 AND birth_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE DIRECTOR IS 'Film directors with their biographical information';

-- ============================================================================
-- ACTOR Table
-- Actors and actresses information
-- ============================================================================
CREATE TABLE ACTOR (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER CHECK (birth_year > 1850 AND birth_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE ACTOR IS 'Actors and actresses appearing in movies';

-- ============================================================================
-- STUDIO Table
-- Production studios
-- ============================================================================
CREATE TABLE STUDIO (
    studio_id SERIAL PRIMARY KEY,
    studio_name VARCHAR(100) NOT NULL,
    founded_year INTEGER CHECK (founded_year > 1880),
    country_id INTEGER REFERENCES COUNTRY(country_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE STUDIO IS 'Film production studios and companies';

-- ============================================================================
-- MOVIE Table
-- Core movie information
-- ============================================================================
CREATE TABLE MOVIE (
    movie_id SERIAL PRIMARY KEY,
    imdb_id VARCHAR(20) UNIQUE,
    title VARCHAR(200) NOT NULL,
    year INTEGER NOT NULL CHECK (year > 1880 AND year <= EXTRACT(YEAR FROM CURRENT_DATE) + 5),
    runtime INTEGER CHECK (runtime > 0),
    imdb_rating DECIMAL(3,1) CHECK (imdb_rating >= 0 AND imdb_rating <= 10),
    imdb_votes INTEGER DEFAULT 0,
    plot TEXT,
    box_office VARCHAR(50),
    release_date DATE,
    director_id INTEGER REFERENCES DIRECTOR(director_id),
    studio_id INTEGER REFERENCES STUDIO(studio_id),
    sequel_of INTEGER REFERENCES MOVIE(movie_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE MOVIE IS 'Core movie information including ratings and financial data';
COMMENT ON COLUMN MOVIE.imdb_id IS 'IMDb unique identifier (e.g., tt1234567)';
COMMENT ON COLUMN MOVIE.sequel_of IS 'Self-referencing FK for sequels';

-- ============================================================================
-- MOVIE_GENRE Table (Junction)
-- Many-to-many relationship between movies and genres
-- ============================================================================
CREATE TABLE MOVIE_GENRE (
    movie_id INTEGER REFERENCES MOVIE(movie_id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES GENRE(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);

COMMENT ON TABLE MOVIE_GENRE IS 'Junction table linking movies to their genres';

-- ============================================================================
-- MOVIE_CAST Table (Junction)
-- Many-to-many relationship between movies and actors
-- ============================================================================
CREATE TABLE MOVIE_CAST (
    movie_id INTEGER REFERENCES MOVIE(movie_id) ON DELETE CASCADE,
    actor_id INTEGER REFERENCES ACTOR(actor_id) ON DELETE CASCADE,
    role VARCHAR(100),
    billing_order INTEGER,
    PRIMARY KEY (movie_id, actor_id)
);

COMMENT ON TABLE MOVIE_CAST IS 'Junction table linking movies to actors with role information';

-- ============================================================================
-- AWARD Table
-- Movie awards and nominations
-- ============================================================================
CREATE TABLE AWARD (
    award_id SERIAL PRIMARY KEY,
    award_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    year_awarded INTEGER NOT NULL,
    movie_id INTEGER REFERENCES MOVIE(movie_id) ON DELETE CASCADE,
    is_winner BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE AWARD IS 'Movie awards including Academy Awards, Golden Globes, etc.';

-- ============================================================================
-- USER_RATING Table
-- User reviews and ratings
-- ============================================================================
CREATE TABLE USER_RATING (
    rating_id SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES MOVIE(movie_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL,
    rating DECIMAL(2,1) CHECK (rating >= 1 AND rating <= 10),
    review TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE USER_RATING IS 'User-submitted ratings and reviews for movies';

-- ============================================================================
-- Indexes for Performance
-- ============================================================================
CREATE INDEX idx_movie_year ON MOVIE(year);
CREATE INDEX idx_movie_rating ON MOVIE(imdb_rating);
CREATE INDEX idx_movie_director ON MOVIE(director_id);
CREATE INDEX idx_movie_studio ON MOVIE(studio_id);
CREATE INDEX idx_award_movie ON AWARD(movie_id);
CREATE INDEX idx_user_rating_movie ON USER_RATING(movie_id);
CREATE INDEX idx_movie_cast_actor ON MOVIE_CAST(actor_id);
CREATE INDEX idx_movie_genre_genre ON MOVIE_GENRE(genre_id);

-- ============================================================================
-- Views
-- ============================================================================

-- View: High-rated movies (rating > 8.0)
CREATE OR REPLACE VIEW high_rated_movies AS
SELECT movie_id, title, year, imdb_rating
FROM MOVIE
WHERE imdb_rating > 8.0
ORDER BY imdb_rating DESC;

COMMENT ON VIEW high_rated_movies IS 'Movies with IMDb rating above 8.0';

-- View: Movie summary with director
CREATE OR REPLACE VIEW movie_summary AS
SELECT
    m.movie_id,
    m.title,
    m.year,
    m.imdb_rating,
    d.name AS director_name,
    s.studio_name
FROM MOVIE m
LEFT JOIN DIRECTOR d ON m.director_id = d.director_id
LEFT JOIN STUDIO s ON m.studio_id = s.studio_id;

COMMENT ON VIEW movie_summary IS 'Comprehensive movie view with director and studio info';

-- ============================================================================
-- Schema creation complete
-- ============================================================================
