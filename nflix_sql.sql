-- 3. Créer une base de données ‘netflix’ 
create database netflix;

use netflix;


--4. Créer une table appelée ‘netflix_title’, importer les données provenant du fichier netflix_titles.csv 
CREATE TABLE netflix.netflix_titles (
    show_id INT NOT NULL,
    type VARCHAR(8),
    title VARCHAR(105) NOT NULL,
    director VARCHAR(209),
    cast VARCHAR(772),
    country VARCHAR(124),
    date_added VARCHAR(19),
    release_year INT, 
    rating VARCHAR(9),
    duration VARCHAR(11),
    listed_in VARCHAR(79),
    description VARCHAR(251),
    PRIMARY KEY (show_id)
);

LOAD DATA LOCAL INFILE '/home/julien/Documents/20201109_SQL/netflix_titles.csv'
INTO TABLE netflix.netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


--5. Créer une table appelée ‘netflix_shows’ provenant du fichier Netflix Shows.csv
CREATE TABLE netflix.netflix_shows (
    title VARCHAR(64) NOT NULL,
    rating VARCHAR(9) NOT NULL,
    ratingLevel VARCHAR(126),
    ratingDescription INT,
    release_year INT,
    user_rating_score FLOAT,
    user_rating_size INT,
    id INT NOT NULL AUTO_INCREMENT, -- 'id' as last column otherwise CSV is not imported properly
    PRIMARY KEY (id)
);

LOAD DATA LOCAL INFILE '/home/julien/Documents/20201109_SQL/Netflix_Shows.csv'
INTO TABLE netflix.netflix_shows
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


--6. Afficher tous les titres de films de la table netflix_titles dont l’ID est inférieur strict à 80000000 
SELECT netflix.netflix_titles.title 
FROM netflix.netflix_titles
WHERE netflix.netflix_titles.show_id < 80000000 ;
-- 1346 entries for a table of 6234 rows.


--7. Afficher toutes les durée des TV Show (colonne duration)
SELECT netflix.netflix_titles.duration 
FROM netflix.netflix_titles
WHERE netflix.netflix_titles.`type` = 'TV Show';
-- 1969 entries for a table of 6234 rows


--8. Réaliser une veille sur ces notions MySQL (https://sql.sh/fonctions/right) 
-- a. Tri des données   https://sql.sh/cours/order-by 
-- b. Renommage         https://sql.sh/cours/alter-table
-- c. Agrégation        https://sql.sh/cours/group-by
-- d. Jointures         https://sql.sh/cours/jointures
-- e. Opération 


--9. Afficher tous les noms de films communs aux 2 tables (netflix_titles et netflix_shows)
SELECT DISTINCT netflix.netflix_titles.title
FROM netflix.netflix_titles 
INNER JOIN netflix.netflix_shows 
ON netflix.netflix_titles.title = netflix.netflix_shows.title;
-- 242 entries for a table of 6234 rows


--10. Calculer la durée totale de tous les films (Movie)S de votre table netflix_titles
-- 'duration' column in netflix_titles contains varchar (e.g. "127 min"), not numerical values.
-- The following SQL is run on a different netflix_titles where the imported CSV has been 'cleaned up'
-- (the ' min' for 'minutes' has been removed) so as to have the duration column as 'INT':
SELECT SUM(netflix.netflix_titles.duration)
FROM netflix.netflix_titles
WHERE netflix.netflix_titles.`type` = 'TV Show';
-- 422 665 minutes total for a table of 6234 rows


--11. Compter le nombre de TV Shows de votre table ‘netflix_shows’ dont le ‘ratingLevel’ est renseigné.
-- Note: after importing the CSV, empty ‘ratingLevel’ cells contain an empty string (and not a NULL-value).
-- All shows, only using the netflix_shows table:
SELECT COUNT(netflix.netflix_shows.title)
FROM netflix.netflix_shows
WHERE netflix.netflix_shows.ratingLevel != '';
-- 941 entries for a table of 1000 rows

-- Using an INNER JOIN on netflix_titles to filter on 'TV Show':
SELECT COUNT(netflix.netflix_shows.title)
FROM netflix.netflix_shows 
INNER JOIN netflix.netflix_titles 
ON netflix.netflix_shows.title = netflix.netflix_titles.title
WHERE netflix.netflix_shows.ratingLevel != '' AND netflix.netflix_titles.`type` = 'TV Show';
-- 374 entries for a table of 1000 rows


--12. Compter les films et TV Shows pour lesquels les noms (title) sont les mêmes sur les 2 tables et dont le ‘release year’ est supérieur à 2016.
SELECT COUNT(netflix.netflix_titles.title)
FROM netflix.netflix_titles 
INNER JOIN netflix.netflix_shows 
ON netflix.netflix_titles.title = netflix.netflix_shows.title
WHERE netflix.netflix_shows.release_year > 2016;
-- 48 entries (18 distinct) for a table of 6234 rows


--13. Supprimer la colonne ‘rating’ de votre table ‘netflix_shows’ 
ALTER TABLE netflix.netflix_shows
DROP netflix.netflix_shows.rating;


--14. Supprimer les 100 dernières lignes de la table ‘netflix_shows’ 
DELETE FROM netflix.netflix_shows ORDER BY id DESC LIMIT 100;


--15. Le champs “ratingLevel” pour le TV show “Marvel's Iron Fist” de la table ‘netflix_shows’ est vide, pouvez-vous ajouter un commentaire ? 
UPDATE netflix.netflix_shows
SET ratingLevel = 'A new comment'
WHERE netflix.netflix_shows.title = 'Marvel\'s Iron Fist' AND netflix.netflix_shows.ratingLevel = '';




