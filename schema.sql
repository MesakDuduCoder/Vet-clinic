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
ADD PRIMARY KEY (id);

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

CREATE TABLE vets (
  id SERIAL,
  name VARCHAR(100) NOT NULL,
  age INTEGER NOT NULL,
  date_of_graduation DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  vet_id INTEGER,
  species_id INTEGER
);

ALTER TABLE specializations
ADD CONSTRAINT fk_3
FOREIGN KEY (vet_id) REFERENCES vets (id);

ALTER TABLE specializations
ADD CONSTRAINT fk_4
FOREIGN KEY (species_id) REFERENCES species (id);

CREATE TABLE visits (
  animal_id INTEGER,
  vet_id INTEGER,
  date_of_visit DATE NOT NULL
);

ALTER TABLE visits
ADD CONSTRAINT fk_5
FOREIGN KEY (vet_id) REFERENCES vets (id);

ALTER TABLE visits
ADD CONSTRAINT fk_6
FOREIGN KEY (animal_id) REFERENCES animals (id);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX index_visit_animal_id ON visits(animal_id);

CREATE INDEX index_visit_vet_id ON visits(vet_id);

CREATE INDEX index_owners_email ON owners(email);