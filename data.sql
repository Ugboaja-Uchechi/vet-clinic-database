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

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');


UPDATE animals set species_id= (SELECT ID FROM species WHERE name='Digimon')
WHERE name like '%mon';

BEGIN;
UPDATE animals set species_id= (SELECT ID FROM species WHERE name='Digimon') WHERE name like '%mon';

UPDATE animals set species_id= (SELECT ID FROM species WHERE name='Pokemon') WHERE species_id is null;
COMMIT;

--Modify your inserted animals to include owner information (owner_id):

--Sam Smith owns Agumon.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Sam Smith') WHERE name= 'Agumon';

--Jennifer Orwell owns Gabumon and Pikachu.

UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Jennifer Orwell') WHERE name in ('Gabumon','Pikachu');

--Bob owns Devimon and Plantmon.

UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Bob') WHERE name in ('Devimon','Plantmon');

--Melody Pond owns Charmander, Squirtle, and Blossom.

UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Melody Pond') WHERE name in ('Charmander','Squirtle','Blossom');

--Dean Winchester owns Angemon and Boarmon.

UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Dean Winchester') WHERE name in ('Angemon','Boarmon');