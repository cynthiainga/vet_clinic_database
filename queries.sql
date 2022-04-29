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
  species.id = animals.species_id
GROUP BY species.name;

SELECT
  animals.name,
  owners.full_name,
  species.name
FROM
  animals
JOIN
  species
ON
  species.id = animals.species_id
JOIN
  owners
ON
  owners.id = animals.owners_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT * 
FROM
  animals
JOIN owners
ON
  animals.owners_id = owners.id
WHERE
  animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT
  owners.full_name,
  COUNT(*)
FROM
  animals
JOIN
  owners
ON
  animals.owners_id = owners.id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

SELECT
  vets.name,
  animals.name,
  date_of_visit
FROM
  animals
JOIN
  visits
ON
  visits.animals_id = animals.id
JOIN
  vets
ON
  visits.vets_id = vets.id
WHERE
  vets.name = 'William Tatcher'
ORDER BY
  date_of_visit DESC
LIMIT
  1;

SELECT
  COUNT(DISTINCT animals.name)
FROM
  visits
JOIN
  animals
ON
  visits.animals_id = animals.id
JOIN
  vets
ON
  visits.vets_id = vets.id
WHERE
  vets.name = 'Stephanie Mendez';

SELECT
  vets.name, species_id as speciality_id
FROM
  specializations
RIGHT JOIN
  vets
ON
  specializations.vet_id = vets.id;

SELECT
  animals_id,
  animals.name,
  visits.date_of_visit,
  vets.name
FROM
  animals
JOIN
  visits
ON
  visits.animals_id = animals.id
JOIN
  vets
ON
  visits.vets_id = vets.id
WHERE
  vets.name = 'Stephanie Mendez'
  AND
    visits.date_of_visit
    BETWEEN '2020-04-01' AND '2020-08-30';

SELECT
  animals.name,
  COUNT(*) AS visits
FROM
  visits
JOIN
  animals
ON 
  visits.animals_id = animals.id 
GROUP BY
  animals.name
ORDER BY
  visits DESC;

SELECT
  animals_id,
  vets.name,
  animals.name,
  visits.date_of_visit
FROM
  visits
  JOIN vets Ve ON visits.vets_id = vets.id
  JOIN animals ON visits.animals_id = animals.id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  date_of_visit
ASC LIMIT
  1;

SELECT
  animals.name AS animal,
  date_of_visits,
  vets.name AS "Vet name",
FROM
  aniamls
  JOIN vets ON visits.vets_id = vets.id
  JOIN visits ON visits.animals_id = animals.id
ORDER BY
  date_of_visit DESC
LIMIT
  1;

SELECT
  COUNT(*)
FROM
  visits
LEFT JOIN 
  specializations
ON 
  visits.vets_id = specializations.vets_id
JOIN 
  animals
ON 
  visits.animals_id = animals.id
WHERE
  specializations.species_id <> animals.species_id
  OR
  specializations.species_id IS NULL;

SELECT
  COUNT(*) AS species
FROM
  visits
FULL OUTER JOIN
  vets
ON
  visits.vets_id = vets.id
FULL OUTER JOIN
  specializations
ON
  specializations.vets_id = vets.id
WHERE
  species_id IS NULL;