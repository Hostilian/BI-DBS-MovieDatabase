-- ============================================================================
-- BI-DBS Movie Database - Drop Schema Script
-- Use this to clean up the database
-- ============================================================================

-- Drop views first
DROP VIEW IF EXISTS movie_summary CASCADE;
DROP VIEW IF EXISTS high_rated_movies CASCADE;

-- Drop tables in correct order (respecting foreign keys)
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

-- Confirmation message
DO $$
BEGIN
    RAISE NOTICE 'All tables and views have been dropped successfully.';
END $$;
