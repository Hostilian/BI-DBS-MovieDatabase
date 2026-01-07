# BI-DBS Movie Database Project 🎬

[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Course](https://img.shields.io/badge/Course-BI--DBS-orange)](https://czu.dbsportal.cz)
[![Queries](https://img.shields.io/badge/Queries-41-green)](./queries/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A comprehensive movie database project for the **BI-DBS (Database Systems)** course at Czech University of Life Sciences Prague. This project demonstrates SQL query writing, Relational Algebra operations, and database design principles.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Query Categories](#query-categories)
- [Project Requirements](#project-requirements)
- [Installation](#installation)
- [Query Examples](#query-examples)
- [File Structure](#file-structure)
- [References](#references)

## 🎯 Project Overview

This project implements a **Movie Database** system that tracks:
- 🎬 Movies with detailed information (title, year, runtime, IMDb ratings, box office)
- 🎭 Actors and their filmography
- 🎥 Directors and their works
- 🏆 Awards and nominations
- 🎪 Genres and movie classifications
- 🏢 Studios and production companies
- 🌍 Countries of origin
- ⭐ User ratings and reviews

### Statistics
| Metric | Count |
|--------|-------|
| Total SQL Queries | 41 |
| Natural Language Queries | 41 |
| Relational Algebra Queries | 41 |
| Database Tables | 10+ |
| Category Coverage | 26 categories |

## 🗄️ Database Schema

### Entity-Relationship Diagram

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   COUNTRY   │       │   STUDIO    │       │  DIRECTOR   │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ country_id  │◄──────│ country_id  │       │ director_id │
│ country_name│       │ studio_id   │◄──┐   │ name        │
│ country_code│       │ studio_name │   │   │ birth_year  │
└─────────────┘       │ founded_year│   │   └──────┬──────┘
                      └─────────────┘   │          │
                                        │          │
┌─────────────┐       ┌─────────────┐   │   ┌──────▼──────┐
│    GENRE    │       │ MOVIE_GENRE │   │   │    MOVIE    │
├─────────────┤       ├─────────────┤   │   ├─────────────┤
│ genre_id    │◄──────│ genre_id    │   │   │ movie_id    │
│ genre_name  │       │ movie_id    │───┼───│ imdb_id     │
└─────────────┘       └─────────────┘   │   │ title       │
                                        │   │ year        │
┌─────────────┐       ┌─────────────┐   │   │ runtime     │
│    ACTOR    │       │  MOVIE_CAST │   │   │ imdb_rating │
├─────────────┤       ├─────────────┤   │   │ director_id │
│ actor_id    │◄──────│ actor_id    │   └───│ studio_id   │
│ name        │       │ movie_id    │───────│ sequel_of   │
│ birth_year  │       │ role        │       └──────┬──────┘
└─────────────┘       └─────────────┘              │
                                                   │
                      ┌─────────────┐       ┌──────▼──────┐
                      │ USER_RATING │       │    AWARD    │
                      ├─────────────┤       ├─────────────┤
                      │ rating_id   │       │ award_id    │
                      │ movie_id    │───────│ movie_id    │
                      │ user_id     │       │ award_name  │
                      │ rating      │       │ category    │
                      │ review      │       │ year_awarded│
                      └─────────────┘       │ is_winner   │
                                            └─────────────┘
```

### Tables Overview

| Table | Description | Key Fields |
|-------|-------------|------------|
| `MOVIE` | Core movie information | movie_id, title, year, imdb_rating |
| `DIRECTOR` | Film directors | director_id, name, birth_year |
| `ACTOR` | Actors/actresses | actor_id, name, birth_year |
| `GENRE` | Movie genres | genre_id, genre_name |
| `STUDIO` | Production studios | studio_id, studio_name |
| `COUNTRY` | Countries | country_id, country_name |
| `AWARD` | Movie awards | award_id, award_name, category |
| `MOVIE_GENRE` | Movie-Genre junction | movie_id, genre_id |
| `MOVIE_CAST` | Movie-Actor junction | movie_id, actor_id, role |
| `USER_RATING` | User reviews | rating_id, movie_id, rating |

## 📊 Query Categories

The project covers all required SQL query categories:

### Basic Operations
| Category | Description | Example Query |
|----------|-------------|---------------|
| **A** | SELECT with JOIN | D4, D5, D7-D11, D19, D27, D28, D37, D41 |
| **B** | NOT IN / NOT EXISTS | D3 |
| **C** | Two relations in FROM | D4 |

### Set Operations
| Category | Description | Example Query |
|----------|-------------|---------------|
| **D1** | Projection (π) | D1, D5 |
| **D2** | Selection with nested query | D6 |

### Join Operations
| Category | Description | Example Query |
|----------|-------------|---------------|
| **F1** | Subquery in FROM | D5, D28 |
| **F2** | INNER JOIN | D4, D7-D11, D19, D37 |
| **F3** | CROSS JOIN | D25 |
| **F4** | LEFT OUTER JOIN | D41 |
| **F5** | FULL OUTER JOIN | D27 |

### Advanced Operations
| Category | Description | Example Query |
|----------|-------------|---------------|
| **G1** | EXISTS | D5, D18 |
| **G2** | Aggregate in nested query | D28 |
| **G3** | ANY/SOME | - |
| **G4** | ALL | D5 |
| **H1** | UNION | D15 |
| **H2** | EXCEPT/MINUS | D3, D17 |
| **H3** | INTERSECT | D16 |

### Grouping & Aggregation
| Category | Description | Example Query |
|----------|-------------|---------------|
| **I1** | GROUP BY | D28, D31 |
| **I2** | Aggregate functions | D28, D31 |
| **J** | GROUP BY with HAVING | - |
| **K** | ORDER BY | D32 |
| **L** | CASE expression | D33 |
| **M** | Comparison operators | D22 |

### String & Date Operations
| Category | Description | Example Query |
|----------|-------------|---------------|
| **N** | LIKE pattern matching | D34 |
| **O** | Date functions | D35 |
| **P** | Views | D36 |

## ✅ Project Requirements

### Completion Status

| Requirement | Status |
|-------------|--------|
| References filled | ✅ |
| Natural queries with text | ✅ |
| 25+ SQL queries | ✅ (41 queries) |
| SQL returns valid results | ✅ |
| Category coverage (A-P) | ✅ |
| Create script uploaded | ✅ |
| Create script valid | ✅ |
| Insert script uploaded | ✅ |
| Tables have records | ✅ |
| Insert script valid | ✅ |
| 25+ natural queries | ✅ (41 queries) |
| RA = SQL results | ✅ |
| 10+ RA queries | ✅ (41 queries) |
| RA returns valid results | ✅ |

## 🚀 Installation

### Prerequisites
- PostgreSQL 12+ or compatible database
- SQL client (pgAdmin, DBeaver, etc.)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/BI-DBS-MovieDatabase.git
   cd BI-DBS-MovieDatabase
   ```

2. **Create the database**
   ```sql
   CREATE DATABASE movie_database;
   ```

3. **Run the create script**
   ```bash
   psql -d movie_database -f scripts/create_schema.sql
   ```

4. **Populate with sample data**
   ```bash
   psql -d movie_database -f scripts/insert_data.sql
   ```

5. **Create views**
   ```bash
   psql -d movie_database -f scripts/create_views.sql
   ```

## 📝 Query Examples

### D1 - Basic Projection
**Natural Language:** Show only the title and year for every movie to build a compact catalog view.

**SQL:**
```sql
SELECT title, year FROM MOVIE;
```

**Relational Algebra:**
```
π title, year (MOVIE)
```

### D5 - Universal Quantification
**Natural Language:** Find actors who have appeared in every genre.

**SQL:**
```sql
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
```

### D28 - Subquery with Aggregation
**Natural Language:** Find directors with their average movie rating.

**SQL:**
```sql
SELECT d.name, sub.avg_rating
FROM DIRECTOR d
JOIN (
    SELECT director_id, AVG(imdb_rating) as avg_rating
    FROM MOVIE
    GROUP BY director_id
) sub ON d.director_id = sub.director_id
ORDER BY sub.avg_rating DESC;
```

## 📁 File Structure

```
BI-DBS-MovieDatabase/
├── README.md                    # This file
├── LICENSE                      # MIT License
├── docs/
│   ├── index.html              # GitHub Pages documentation
│   ├── schema.md               # Detailed schema documentation
│   └── queries.md              # All queries with explanations
├── scripts/
│   ├── create_schema.sql       # CREATE TABLE statements
│   ├── insert_data.sql         # INSERT statements
│   ├── create_views.sql        # VIEW definitions
│   └── drop_schema.sql         # Cleanup script
├── queries/
│   ├── basic/                  # D1-D14 basic queries
│   ├── joins/                  # D15-D28 join queries
│   ├── advanced/               # D29-D41 advanced queries
│   └── all_queries.sql         # All queries in one file
├── relational_algebra/
│   └── ra_queries.md           # Relational Algebra expressions
└── original/
    ├── 66Queries_Edit_BI-DBS.html
    └── 66Queries_Edit_BI-DBS_files/
```

## 📚 References

No external sources were used in the creation of this database project. All SQL queries, relational algebra expressions, and database design were created independently based on course materials and PostgreSQL documentation.

## 👤 Author

- **Student ID:** xozte001
- **Course:** BI-DBS.21 DBS-2025
- **Semester:** 2
- **Institution:** Czech University of Life Sciences Prague

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <sub>Built with ❤️ for BI-DBS course | Data Modeller v9.2.1 | © 2026 ČVUT FIT</sub>
</p>
