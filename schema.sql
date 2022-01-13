/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
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
ADD PRIMARY KEY (id)

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