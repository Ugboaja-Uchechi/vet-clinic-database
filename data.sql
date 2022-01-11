/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, '1', 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, '1', 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, '0', 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, '1', 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '2022-11-15', 2, true, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);

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

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

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