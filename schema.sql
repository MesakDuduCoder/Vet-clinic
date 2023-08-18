/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INTEGER NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL NOT NULL
);

CREATE TABLE owners (
  id SERIAL,
  full_name VARCHAR(200) NOT NULL,
  age INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE species (
  id SERIAL,
  name VARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE animals
RENAME COLUMN id TO temp_column;

ALTER TABLE animals
ADD id SERIAL;

UPDATE animals
SET id = temp_column;

ALTER TABLE animals
DROP COLUMN temp_column;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INTEGER;

ALTER TABLE animals
ADD CONSTRAINT fk_1
FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
ADD CONSTRAINT fk_2
FOREIGN KEY (owner_id) REFERENCES owners (id);