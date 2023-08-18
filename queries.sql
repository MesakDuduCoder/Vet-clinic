/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

-- What animals belong to Melody Pond?
SELECT full_name,name FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.id = 4;

-- List of all animals that are pokemon
SELECT animals.name,species.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal
SELECT owners.full_name,animals.name
FROM animals
RIGHT JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.name),species.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT owners.full_name,animals.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' and owners.id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT owners.full_name,animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.id = 5 and animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) AS animal_count
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;