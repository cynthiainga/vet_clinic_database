/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth  BETWEEN '2016/01/01' AND '2019/12/31';
SELECT name FROM animals WHERE neutered = true  AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified' WHERE species IS NULL;
ROLLBACK; 

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022/01/01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = -1 * weight_kg;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT id, name, escape_attempts FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals) AND (neutered = true OR neutered = false);
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth  BETWEEN '1990/01/01' AND '2000/12/31';

SELECT
  animals.id,
  animals.name
FROM
  animals
JOIN
  owners
ON
  animals.owners_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

SELECT
  animals.id,
  animals.name
FROM
  animals
JOIN
  species
ON
  animals.species_id =species.id
WHERE
  species.name = 'Pokemon';

SELECT
  animals.name,
  owners.full_name
FROM
  owners
LEFT JOIN
  animals
ON
  owners.id = animals.owners_id;

SELECT
  species.name,
  COUNT(*)
FROM
  animals
JOIN
  species
ON
  species.id = animals.species_id,
GROUP BY species.name;