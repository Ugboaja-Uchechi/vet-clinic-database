/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered='true' AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered='true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.
BEGIN;
UPDATE animals SET species = 'unspecified'
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