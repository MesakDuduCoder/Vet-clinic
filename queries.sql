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

-- Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, visits.date_of_visit
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE visits.vet_id = 1
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(animals.name)
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE visits.vet_id = 3
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, date_of_visit
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE visits.vet_id = 3 and date_of_visit BETWEEN '2020-04-01' and '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.name)
FROM visits 
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, visits.date_of_visit
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE visits.vet_id = 2
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id AS animal_id, animals.name AS animal_name, animals.escape_attempts,
animals.neutered, animals.date_of_birth, animals.weight_kg, animals.species_id,
animals.owner_id, vets.id AS vet_id, vets.name AS vet_name, vets.age,
vets.date_of_graduation, visits.date_of_visit
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(date_of_visit), specializations.species_id
FROM vets
LEFT JOIN visits ON visits.vet_id = vets.id
LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE specializations.species_id IS NULL
GROUP BY vets.name,specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, COUNT(animals.name), animals.species_id, species.name
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE visits.vet_id = 2
GROUP BY vets.name,animals.species_id,species.name;

-- Pair programming
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';