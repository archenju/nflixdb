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
LINES TERMINATED BY '\n'
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
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


--6. Afficher tous les titres de films de la table netflix_titles dont l’ID est inférieur strict à 80000000 
SELECT netflix.netflix_titles.title 
FROM netflix.netflix_titles
WHERE netflix.netflix_titles.show_id > 80000000
;


--7. Afficher toutes les durée des TV Show (colonne duration)
SELECT netflix.netflix_titles.duration 
FROM netflix.netflix_titles
WHERE netflix.netflix_titles.`type` = 'TV Show'
;


--8. Réaliser une veille sur ces notions MySQL (https://sql.sh/fonctions/right) 
-- a. Tri des données   https://sql.sh/cours/order-by 
-- b. Renommage         https://sql.sh/cours/alter-table
-- c. Agrégation 
-- d. Jointures 
-- e. Opération 




--9. Afficher tous les noms de films communs aux 2 tables (netflix_titles et netflix_shows)
SELECT DISTINCT netflix.netflix_titles.title 
FROM netflix.netflix_titles, netflix.netflix_shows
WHERE netflix.netflix_titles.`type` = 'Movie'
AND netflix.netflix_titles.title = netflix.netflix_shows.title
;









