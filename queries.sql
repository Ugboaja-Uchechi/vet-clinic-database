/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered='true' AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered='true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- SELECT name FROM animals WHERE date_of_birth BETWEEN '2022-12-31' AND '1993-01-01';

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals SET species = 'pokemon' WHERE species = null;

-- COMMIT THE TRANSACTION
COMMIT;

-- Verify that change was made and persists after commit.

SELECT * FROM animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |       8.0 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |      11.0 | digimon
--   6 | Plantmon   | 2022-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |     -45.0 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |     -11.0 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |      17.0 | pokemon
-- (10 rows)

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

--After the roll back verify if all records in the animals table still exist.

SELECT * FROM animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |       8.0 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |      11.0 | digimon
--   6 | Plantmon   | 2022-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |     -45.0 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |     -11.0 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |      17.0 | pokemon
-- (10 rows)

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-22';

-- CREATE A SAVE POINT FOR THE TRANSACTION
SAVEPOINT first_delete;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- ROLLBACK TO THE SAVEPOINT
ROLLBACK TO first_delete;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- COMMIT TRANSACTION
COMMIT;

-- Verify that change was made and persists after commit.

SELECT * FROM animals;

-- id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |       8.0 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |      11.0 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |      17.0 | pokemon
--   8 | Angemon    | 2005-06-12    |               1 | t        |      45.0 | digimon
--   5 | Charmander | 2020-02-08    |               0 | f        |      11.0 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
-- (9 rows)



-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts <= 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, escape_attempts FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name, owners.full_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(species.name) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name, animals.escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts <= 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name;


-- DAY 4

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, date_of_visits FROM visits JOIN animals ON animals.id = animals_id JOIN vets ON vets.id = vets_id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visits DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(animals_id) FROM visits JOIN animals ON animals.id = animals_id JOIN vets ON vets.id = vets_id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets_id = vets.id LEFT JOIN species ON species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id WHERE date_of_visits BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez' ORDER BY animals.name;

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.name) FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, date_of_visits FROM visits JOIN animals ON animals.id = animals_id JOIN vets ON vets.id = vets_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visits LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation, visits.date_of_visits FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id ORDER BY date_of_visits DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(date_of_visits) FROM vets LEFT JOIN visits ON vets.id = visits.vets_id LEFT JOIN specializations ON vets.id = specializations.vets_id WHERE specializations.species_id IS NULL GROUP BY vets.name;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name) FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id JOIN species ON animals.species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(species.name) DESC LIMIT 1;
