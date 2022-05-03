/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name varchar(40),
  date_of_birth date,
  escape_attempts INT NOT NULL,
  neutered boolean,
  weight_kg decimal(5, 2)
);

ALTER TABLE animals ADD species varchar(255);

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name varchar(255),
  age INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name varchar(255),
  PRIMARY KEY (id)
);

ALTER TABLE animals ALTER COLUMN id  DROP IDENTITY IF EXISTS;
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals DROP species;

BEGIN;

ALTER TABLE 
  animals
ADD
  species_id INTEGER;

ALTER TABLE 
  animals
ADD
  owners_id INTEGER;

ALTER TABLE
  animals
ADD CONSTRAINT
  fk_owner
FOREIGN KEY(owners_id)
REFERENCES
  owners(id);

ALTER TABLE
  animals
ADD CONSTRAINT
  fk_species
FOREIGN KEY(species_id)
REFERENCES
  species(id);

COMMIT;

CREATE TABLE vets(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name varchar(100),
  age INTEGER,
  date_of_graduation date,
  PRIMARY KEY (id)
);

 CREATE TABLE specializations(
  vets_id INT NOT NULL,
  species_id INT NOT NULL,
  FOREIGN KEY (vets_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits(
  animals_id INT NOT NULL,
  vets_id INT NOT NULL,
  date_of_visit DATE NOT NULL,
  FOREIGN KEY (animals_id) REFERENCES animals (id),
  FOREIGN KEY (vets_id) REFERENCES vets (id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);