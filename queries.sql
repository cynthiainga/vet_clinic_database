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
  vet.name AS Vet_Name,
  Specialities.name AS Speciality
FROM
  vets vet
LEFT JOIN
  specializations
ON
  vet.id = specializations.vets_id
LEFT JOIN
  species Specialities
ON
  specializations.species_id = Specialities.id;

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
  animal.name AS aniamls,
  COUNT(animal.name) AS visited
FROM
  animals animal
JOIN
  visits visit
ON 
  visit.animals_id = animal.id
JOIN
  vets vet
ON
  visit.vets_id = vet.id
GROUP BY
  animal.name
ORDER BY
  visited DESC
LIMIT
  1;

SELECT
  animals_id,
  vets.name,
  animals.name,
  visits.date_of_visit
FROM
  visits
  JOIN vets ON visits.vets_id = vets.id
  JOIN animals ON visits.animals_id = animals.id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  date_of_visit
ASC LIMIT
  1;

SELECT
  animals.name AS animal,
  animals.date_of_birth AS "Date of Birth",
  animals.escape_attempts AS Escapes,
  animals.neutered AS Neutered,
  animals.weight_kg AS Weigth,
  specy.name AS species,
  vet.name AS "Vet name",
  vet.age AS "Vet age",
  vet.date_of_graduation AS "Date of vet graduation",
  date_of_visit
FROM
  visits visit
  JOIN vets vet ON visit.vets_id = vet.id
  JOIN animals animals ON visit.animals_id = animals.id
  JOIN species specy ON animals.species_id = specy.id
ORDER BY
  date_of_visit DESC
LIMIT
  1;

SELECT
  COUNT(specy.name),
  specy.name
FROM
  visits visit
JOIN 
  animals animal
ON 
  visit.animals_id = animal.id
JOIN 
  species specy
ON 
  animal.species_id = specy.id
JOIN
  vets vet
ON
  visit.vets_id = vet.id
WHERE
  vets_id = 2
GROUP BY(specy.name)
LIMIT
  1;

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