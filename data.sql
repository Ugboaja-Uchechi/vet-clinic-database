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

-- Insert the following data for vets:

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2020-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harness', 38, '2008-06-08');

-- Insert the following data for specialization:

INSERT INTO specializations (species_id, vets_id) VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations (vets_id, species_id) VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon'));
INSERT INTO specializations (vets_id, species_id) VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations (species_id, vets_id) VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));

-- Insert the following data for visits:

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name='William Tatcher'), '2020-05-24');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '2020-07-22');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Gabumon'), (SELECT id FROM vets WHERE name='Jack Harness'), '2020-02-02');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2020-01-05');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2020-03-08');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2020-05-14');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Devimon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '2021-05-04');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Charmander'), (SELECT id FROM vets WHERE name='Jack Harness'), '2021-02-24');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2019-12-21');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='William Tatcher'), '2020-08-10');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2021-04-07');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Squirtle'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '2019-09-29');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harness'), '2020-10-03');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harness'), '2020-11-04');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2019-01-24');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2019-05-15');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2020-02-27');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2020-08-03');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '2020-05-24');

INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES ((SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='Maisy Smith'), '2021-01-11');

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