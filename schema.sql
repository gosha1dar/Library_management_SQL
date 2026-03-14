CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);