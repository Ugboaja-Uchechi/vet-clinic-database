/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DEC(15,2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100)
);

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species(id);


-- DAY 4

CREATE TABLE vets(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    species_id INT,
    vets_id INT,

    CONSTRAINT fk_vets_id
        FOREIGN KEY(vets_id)
            REFERENCES vets(id),

    CONSTRAINT fk_species_id
        FOREIGN KEY(species_id)
            REFERENCES species(id)
);

CREATE TABLE visits(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    animals_id INT,
    vets_id INT,
    date_of_visits DATE,

    CONSTRAINT fk_vets_id
        FOREIGN KEY(vets_id)
            REFERENCES vets(id),

    CONSTRAINT fk_animals_id
        FOREIGN KEY(animals_id)
            REFERENCES animals(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Check running time

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;

explain analyze SELECT * FROM visits where vets_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

-- -- improve execution time;

CREATE INDEX idx_animals_id ON visits(animal_id);

 CREATE INDEX visit_id ON visits(vets_id);

 CREATE INDEX owners_mails ON owners(email);
