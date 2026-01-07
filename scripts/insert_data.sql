-- ============================================================================
-- BI-DBS Movie Database - Sample Data Insert Script
-- Course: BI-DBS.21 DBS-2025
-- Author: xozte001
-- ============================================================================

-- ============================================================================
-- COUNTRY Data
-- ============================================================================
INSERT INTO COUNTRY (country_name, country_code) VALUES
('United States', 'US'),
('United Kingdom', 'UK'),
('Canada', 'CA'),
('Australia', 'AU'),
('New Zealand', 'NZ'),
('France', 'FR'),
('Germany', 'DE'),
('Japan', 'JP'),
('South Korea', 'KR'),
('India', 'IN'),
('Italy', 'IT'),
('Spain', 'ES'),
('Mexico', 'MX');

-- ============================================================================
-- GENRE Data
-- ============================================================================
INSERT INTO GENRE (genre_name) VALUES
('Action'),
('Adventure'),
('Sci-Fi'),
('Drama'),
('Thriller'),
('Comedy'),
('Romance'),
('Horror'),
('Fantasy'),
('Crime'),
('Animation'),
('Documentary'),
('Mystery');

-- ============================================================================
-- DIRECTOR Data
-- ============================================================================
INSERT INTO DIRECTOR (name, birth_year) VALUES
('Christopher Nolan', 1970),
('James Gunn', 1966),
('Denis Villeneuve', 1967),
('Quentin Tarantino', 1963),
('David Fincher', 1962),
('Martin Scorsese', 1942),
('Steven Spielberg', 1946),
('Ridley Scott', 1937),
('Peter Jackson', 1961),
('James Cameron', 1954),
('Greta Gerwig', 1983),
('Jordan Peele', 1979),
('Bong Joon-ho', 1969),
('Taika Waititi', 1975),
('Chloe Zhao', 1982),
('Guillermo del Toro', 1964),
('Alfonso Cuaron', 1961),
('Alejandro Gonzalez Inarritu', 1963),
('Kathryn Bigelow', 1951),
('Ava DuVernay', 1972);

-- ============================================================================
-- ACTOR Data
-- ============================================================================
INSERT INTO ACTOR (name, birth_year) VALUES
('Leonardo DiCaprio', 1974),
('Christian Bale', 1974),
('Chris Pratt', 1979),
('Zoe Saldana', 1978),
('Timothee Chalamet', 1995),
('John Travolta', 1954),
('Samuel L. Jackson', 1948),
('Brad Pitt', 1963),
('Edward Norton', 1969),
('Ray Liotta', 1954),
('Robert De Niro', 1943),
('Tom Hanks', 1956),
('Matt Damon', 1970),
('Russell Crowe', 1964),
('Joaquin Phoenix', 1974),
('Elijah Wood', 1981),
('Ian McKellen', 1939),
('Kate Winslet', 1975),
('Saoirse Ronan', 1994),
('Florence Pugh', 2003),
('Daniel Kaluuya', 1989),
('Choi Woo-shik', 1990),
('Song Kang-ho', 1967),
('Chris Hemsworth', 1983),
('Tom Hiddleston', 1981),
('Cate Blanchett', 1969),
('Frances McDormand', 1957),
('Viola Davis', 1965),
('Meryl Streep', 1949),
('Scarlett Johansson', 1984);

-- ============================================================================
-- STUDIO Data
-- ============================================================================
INSERT INTO STUDIO (studio_name, founded_year, country_id) VALUES
('Warner Bros. Pictures', 1923, 1),
('Marvel Studios', 2005, 1),
('Legendary Pictures', 2000, 1),
('Miramax Films', 1979, 1),
('20th Century Studios', 1935, 1),
('Universal Pictures', 1912, 1),
('New Line Cinema', 1967, 1),
('Paramount Pictures', 1912, 1),
('Sony Pictures', 1987, 1),
('A24', 2012, 1);

-- ============================================================================
-- MOVIE Data
-- ============================================================================
INSERT INTO MOVIE (imdb_id, title, year, runtime, imdb_rating, imdb_votes, plot, box_office, release_date, director_id, studio_id) VALUES
('tt3896198', 'Guardians of the Galaxy Vol. 2', 2017, 136, 7.6, 735000, 'The Guardians struggle to keep together as a team while dealing with their personal family issues.', '$389,813,101', '2017-05-05', 2, 2),
('tt1375666', 'Inception', 2010, 148, 8.8, 2400000, 'A thief who steals corporate secrets through dream-sharing technology is given the task of planting an idea.', '$292,576,195', '2010-07-16', 1, 1),
('tt0468569', 'The Dark Knight', 2008, 152, 9.0, 2700000, 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest tests.', '$534,858,444', '2008-07-18', 1, 1),
('tt1160419', 'Dune', 2021, 156, 8.0, 780000, 'A noble family becomes embroiled in a war for control over the galaxys most valuable asset.', '$108,327,830', '2021-10-22', 3, 3),
('tt0110912', 'Pulp Fiction', 1994, 154, 8.9, 2100000, 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence.', '$107,928,762', '1994-10-14', 4, 4),
('tt0137523', 'Fight Club', 1999, 139, 8.8, 2200000, 'An insomniac office worker and a soap maker form an underground fight club that evolves into much more.', '$37,030,102', '1999-10-15', 5, 5),
('tt0099685', 'Goodfellas', 1990, 145, 8.7, 1200000, 'The story of Henry Hill and his life in the mob, covering his relationship with his mob partners.', '$46,836,394', '1990-09-21', 6, 1),
('tt0120815', 'Saving Private Ryan', 1998, 169, 8.6, 1400000, 'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper.', '$216,540,909', '1998-07-24', 7, 8),
('tt0172495', 'Gladiator', 2000, 155, 8.5, 1500000, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family.', '$187,705,427', '2000-05-05', 8, 6),
('tt0120737', 'The Lord of the Rings: The Fellowship of the Ring', 2001, 178, 8.8, 1900000, 'A meek Hobbit and eight companions set out on a journey to destroy the powerful One Ring.', '$315,544,750', '2001-12-19', 9, 7),
('tt0120338', 'Titanic', 1997, 194, 7.9, 1200000, 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the ill-fated Titanic.', '$674,292,608', '1997-12-19', 10, 8),
('tt1618434', 'Little Women', 2019, 135, 7.8, 200000, 'Jo March reflects back on her life, telling the story of the March sisters growing up in Civil War America.', '$218,000,000', '2019-12-25', 11, 9),
('tt5052448', 'Get Out', 2017, 104, 7.7, 620000, 'A young African-American visits his white girlfriends parents for the weekend with unsettling results.', '$176,040,665', '2017-02-24', 12, 6),
('tt6751668', 'Parasite', 2019, 132, 8.5, 850000, 'Greed and class discrimination threaten the relationship between the wealthy Park family and the Kim clan.', '$53,369,749', '2019-11-08', 13, 10),
('tt3501632', 'Thor: Ragnarok', 2017, 130, 7.9, 700000, 'Thor must race against time to return to Asgard and stop Ragnarok at the hands of the powerful Hela.', '$315,058,289', '2017-11-03', 14, 2);

-- ============================================================================
-- MOVIE_GENRE Data (Many-to-Many)
-- ============================================================================
INSERT INTO MOVIE_GENRE (movie_id, genre_id) VALUES
-- Guardians of the Galaxy Vol. 2 (Action, Adventure, Sci-Fi, Comedy)
(1, 1), (1, 2), (1, 3), (1, 6),
-- Inception (Action, Sci-Fi, Thriller)
(2, 1), (2, 3), (2, 5),
-- The Dark Knight (Action, Crime, Drama, Thriller)
(3, 1), (3, 10), (3, 4), (3, 5),
-- Dune (Action, Adventure, Sci-Fi, Drama)
(4, 1), (4, 2), (4, 3), (4, 4),
-- Pulp Fiction (Crime, Drama, Thriller)
(5, 10), (5, 4), (5, 5),
-- Fight Club (Drama, Thriller)
(6, 4), (6, 5),
-- Goodfellas (Crime, Drama)
(7, 10), (7, 4),
-- Saving Private Ryan (Drama, War)
(8, 4),
-- Gladiator (Action, Adventure, Drama)
(9, 1), (9, 2), (9, 4),
-- LOTR (Adventure, Fantasy, Drama)
(10, 2), (10, 9), (10, 4),
-- Titanic (Drama, Romance)
(11, 4), (11, 7),
-- Little Women (Drama, Romance)
(12, 4), (12, 7),
-- Get Out (Horror, Mystery, Thriller)
(13, 8), (13, 13), (13, 5),
-- Parasite (Drama, Thriller)
(14, 4), (14, 5),
-- Thor: Ragnarok (Action, Adventure, Comedy, Fantasy)
(15, 1), (15, 2), (15, 6), (15, 9);

-- ============================================================================
-- MOVIE_CAST Data (Many-to-Many)
-- ============================================================================
INSERT INTO MOVIE_CAST (movie_id, actor_id, role, billing_order) VALUES
-- Guardians of the Galaxy Vol. 2
(1, 3, 'Peter Quill / Star-Lord', 1),
(1, 4, 'Gamora', 2),
-- Inception
(2, 1, 'Dom Cobb', 1),
-- The Dark Knight
(3, 2, 'Bruce Wayne / Batman', 1),
-- Dune
(4, 5, 'Paul Atreides', 1),
-- Pulp Fiction
(5, 6, 'Vincent Vega', 1),
(5, 7, 'Jules Winnfield', 2),
-- Fight Club
(6, 8, 'Tyler Durden', 1),
(6, 9, 'The Narrator', 2),
-- Goodfellas
(7, 10, 'Henry Hill', 1),
(7, 11, 'Jimmy Conway', 2),
-- Saving Private Ryan
(8, 12, 'Captain John H. Miller', 1),
(8, 13, 'Private James Francis Ryan', 2),
-- Gladiator
(9, 14, 'Maximus Decimus Meridius', 1),
(9, 15, 'Commodus', 2),
-- LOTR
(10, 16, 'Frodo Baggins', 1),
(10, 17, 'Gandalf', 2),
-- Titanic
(11, 1, 'Jack Dawson', 1),
(11, 18, 'Rose DeWitt Bukater', 2),
-- Little Women
(12, 19, 'Jo March', 1),
(12, 20, 'Amy March', 2),
-- Get Out
(13, 21, 'Chris Washington', 1),
-- Parasite
(14, 22, 'Ki-woo', 1),
(14, 23, 'Ki-taek', 2),
-- Thor: Ragnarok
(15, 24, 'Thor', 1),
(15, 25, 'Loki', 2),
(15, 26, 'Hela', 3);

-- ============================================================================
-- AWARD Data
-- ============================================================================
INSERT INTO AWARD (award_name, category, year_awarded, movie_id, is_winner) VALUES
-- Inception awards
('Academy Award', 'Best Cinematography', 2011, 2, TRUE),
('Academy Award', 'Best Visual Effects', 2011, 2, TRUE),
('Academy Award', 'Best Sound Mixing', 2011, 2, TRUE),
-- The Dark Knight awards
('Academy Award', 'Best Supporting Actor', 2009, 3, TRUE),
('Academy Award', 'Best Sound Editing', 2009, 3, TRUE),
-- Dune awards
('Academy Award', 'Best Cinematography', 2022, 4, TRUE),
('Academy Award', 'Best Film Editing', 2022, 4, TRUE),
('Academy Award', 'Best Visual Effects', 2022, 4, TRUE),
-- Pulp Fiction awards
('Academy Award', 'Best Original Screenplay', 1995, 5, TRUE),
('Palme d''Or', 'Best Film', 1994, 5, TRUE),
-- Gladiator awards
('Academy Award', 'Best Picture', 2001, 9, TRUE),
('Academy Award', 'Best Actor', 2001, 9, TRUE),
-- LOTR awards
('Academy Award', 'Best Cinematography', 2002, 10, TRUE),
-- Titanic awards (not won)
('Academy Award', 'Best Picture', 1998, 11, TRUE),
-- Parasite awards
('Academy Award', 'Best Picture', 2020, 14, TRUE),
('Academy Award', 'Best Director', 2020, 14, TRUE),
('Academy Award', 'Best Original Screenplay', 2020, 14, TRUE),
('Academy Award', 'Best International Feature Film', 2020, 14, TRUE);

-- ============================================================================
-- USER_RATING Data
-- ============================================================================
INSERT INTO USER_RATING (movie_id, user_id, rating, review) VALUES
(2, 1, 9.5, 'Mind-bending masterpiece! Nolan at his finest.'),
(2, 2, 9.0, 'Incredible visuals and story.'),
(3, 1, 10.0, 'Best superhero movie ever made.'),
(3, 3, 9.5, 'Heath Ledger was phenomenal.'),
(5, 4, 9.0, 'Tarantino''s dialogue is unmatched.'),
(6, 5, 8.5, 'First rule: you don''t talk about it.'),
(10, 6, 10.0, 'Epic fantasy adventure!'),
(14, 7, 9.0, 'Brilliant social commentary.'),
(14, 8, 9.5, 'Deserved every Oscar it won.');

-- ============================================================================
-- Data insertion complete
-- ============================================================================
