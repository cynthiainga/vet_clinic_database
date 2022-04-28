/* Populate database with sample data. The date is in YY-MM-DD format */

INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Agumon', '2020/02/03', 0, true, 10.23 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Gabumon', '2018/11/15', 2, true, 8 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Pikachu', '2021/01/07', 1, false, 15.04 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Devimon', '2017/05/12', 5, true, 11 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Charmander', '2020/02/08', 0, false, -11 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Plantmon', '2021/11/15', 2, true, -5.7 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Squirtle', '1993/04/02', 3, false, -12.13 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Angemon', '2005/06/12', 1, true, -45 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Boarmon', '2005/06/07', 7, true, 20.4 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Blossom', '1998/10/13', 3, true, 17 );
INSERT INTO animals( name, date_of_birth, escape_attempts, neutered, weight_kg ) VALUES('Ditto', '2022/05/14', 4, true, 22 );

INSERT INTO owners(full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon'),
       ('Digimon');

UPDATE animals SET species_id = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species_id = 'Pokemon' WHERE species_id IS NULL;

UPDATE animals SET owners_id = 'Sam Smith ' WHERE name = 'Agumon';
UPDATE animals SET owners_id = 'Jennifer Orwell ' WHERE name = 'Pikachu' OR name ='Gabumon';
UPDATE animals SET owners_id = 'Bob' WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owners_id = 'Melody Pond ' WHERE name = 'Charmander' OR name ='Squirtle' OR name ='Blossom';
UPDATE animals SET owners_id = 'Dean Winchester' WHERE name = 'Angemon' OR name = 'Boarmon';