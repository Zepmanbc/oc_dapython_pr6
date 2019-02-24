date,Boutique	client	status	prix	paiement_type,paiement 	 	 	
recette	quantité	status	prix


SELECT 
	LEFT(commande.date, 10) AS Date, 
	CONCAT(authentification.prenom, " ", authentification.nom) AS Client, 
	status.designation AS Status, 
	(SELECT SUM(recette.prix)
		FROM recette
		RIGHT JOIN commande_composition ON commande_composition.recette_id = recette.id
	) AS prix, 
	CONCAT(paiement_type.designation, IF(paiement," OK", " ...")) AS Paiement
FROM commande
JOIN authentification ON authentification.id = commande.client_id
JOIN status ON status.id = commande.status_id
JOIN paiement_type ON paiement_type.id = commande.paiement_type_id
WHERE commande.id = 1
UNION
SELECT recette.nom, status.designation, recette.prix, NULL, NULL
FROM commande_composition
JOIN recette ON recette.id = commande_composition.recette_id
JOIN status ON status.id = commande_composition.status_id
WHERE commande_composition.commande_id = 1
ORDER BY recette.nom


SELECT SUM(recette.prix)
FROM recette
RIGHT JOIN commande_composition ON commande_composition.recette_id = recette.id

CALL entete_commande (1)
UNION
CALL corps_commande (1)


DELIMITER |
CREATE PROCEDURE corps_commande(IN `var_recette_id` INT) 
BEGIN
	SELECT 
		recette.nom AS Date, 
		status.designation As Client, 
		recette.prix AS Status, 
		NULL AS prix, 
		NULL AS Paiement
	FROM commande_composition
	JOIN recette ON recette.id = commande_composition.recette_id
	JOIN status ON status.id = commande_composition.status_id
	WHERE commande_composition.commande_id = var_recette_id
	ORDER BY recette.nom;
END|
DELIMITER ;





SELECT 
	CONCAT(authentification.prenom, " ", authentification.nom) AS Client,
	status.designation AS Status,
	(SELECT SUM(recette.prix)
		FROM recette
		RIGHT JOIN commande_composition ON commande_composition.recette_id = recette.id
	) AS prix,
	LEFT(commande.date, 10) AS Date, 
	CONCAT(paiement_type.designation, IF(paiement," OK", " ...")) AS Paiement
	
	FROM commande
	JOIN authentification ON authentification.id = commande.client_id
	JOIN status ON status.id = commande.status_id
	JOIN paiement_type ON paiement_type.id = commande.paiement_type_id
	WHERE commande.id = 1
UNION ALL
SELECT 
	recette.nom, 
	status.designation, 
	recette.prix + 0 AS Prix, 
	"",""
	FROM commande_composition
	JOIN recette ON recette.id = commande_composition.recette_id
	JOIN status ON status.id = commande_composition.status_id
	WHERE commande_composition.commande_id = 1
	
	
	
	
CREATE TRIGGER after_update_commande_composition AFTER UPDATE ON commande_composition FOR EACH ROW 
CASE new.status_id = 2 THEN


END;

UPDATE stock SET stock.quantite -= recette_composition.quantite
JOIN RIGHT ingredient ON ingredient.id = recette_composition,ingredient_id
JOIN stock ON stock.ingredient_id = ingredient.id
JOIN commande ON commande.id = commande_composition.corps_commande
WHERE stock.ingredient = recette_composition.ingredient_id 
and stock.boutique = commande.boutique_id


SELECT recette_composition.ingredient_id, recette_composition.quantite FROM
recette_composition
WHERE recette_composition.recette_id = 1





UPDATE stock SET stock.quantite = stock.quantite - recette_composition.quantite
JOIN recette_composition ON recette_composition.recette_id = commande_composition.recette_id
JOIN commande ON commande.id = commande_composition.id
WHERE stock.ingredient_id = recette_composition.ingredient_id
AND stock.boutique_id = commande.boutique_id


UPDATE stock
JOIN recette_composition ON recette_composition.recette_id = commande_composition.recette_id
JOIN commande ON commande.id = commande_composition.id
WHERE stock.ingredient_id = recette_composition.ingredient_id
AND stock.boutique_id = commande.boutique_id
SET stock.quantite = stock.quantite - recette_composition.quantite

https://stackoverflow.com/questions/11247982/update-multiple-rows-using-select-statement


-- Je veux savoir ce qui est consommé comme ingrédients pour une ligne de commande_composition
SELECT recette_composition.ingredient_id, recette_composition.quantite
FROM recette_composition
WHERE recette_composition.recette_id = (
    SELECT commande_composition.recette_id 
    FROM commande_composition
    WHERE commande_composition.id = 1)

-- Je veux savoir quelle boutique est concerné par une ligne de commande_composition
select commande.boutique_id
FROM commande
JOIN commande_composition ON commande_composition.commande_id = commande.id
WHERE commande_composition.id = 1


UPDATE stock SET quantite = quantite - 1 WHERE ingredient_id > 10 AND boutique_id = 1

-- La liste des ingrédients et la quantité utilisé dans la boutique pour une ligne de commande
SELECT 
	recette_composition.ingredient_id, 
    recette_composition.quantite,
    commande.boutique_id
FROM recette_composition, commande
WHERE recette_composition.recette_id = (
    SELECT commande_composition.recette_id 
    FROM commande_composition
    WHERE commande_composition.id = 1)
AND commande.id = (
    SELECT commande_composition.commande_id 
    FROM commande_composition
    WHERE commande_composition.id = 1);

-- la meme chose plus court
SELECT 
	recette_composition.ingredient_id, 
    recette_composition.quantite,
    commande.boutique_id
FROM recette_composition, commande
WHERE (recette_composition.recette_id, commande.id) = (
    SELECT commande_composition.recette_id,commande_composition.commande_id
    FROM commande_composition
    WHERE commande_composition.id = 1)


-- Structure de curseur

DROP PROCEDURE IF EXISTS `test`;
DELIMITER |
CREATE PROCEDURE test (IN variable INT)
BEGIN
	DECLARE fin TINYINT DEFAULT 0; 
	-- START MODIF
	DECLARE ing, bout, qte INT;
	DECLARE mon_curseur CURSOR FOR
		SELECT * FROM stock;
	-- END MODIF
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
	OPEN mon_curseur;
		loop_curseur: LOOP      
			-- START MODIF
			FETCH mon_curseur INTO ing, bout, qte;
			SELECT ing, bout, qte;
			-- END MODIF
			IF fin = 1 THEN LEAVE loop_curseur;	END IF;	
		END LOOP;
	CLOSE mon_curseur;
END|
DELIMITER ;

-- procedure pour retirer dans le stock

DROP PROCEDURE IF EXISTS `test`;
DELIMITER |
CREATE PROCEDURE test (IN variable INT)
BEGIN
	DECLARE fin TINYINT DEFAULT 0; 
	-- START MODIF
	DECLARE v_ingredient_id, v_quantite, v_boutique_id INT;
	DECLARE mon_curseur CURSOR FOR
		SELECT 
			recette_composition.ingredient_id, 
			recette_composition.quantite,
			commande.boutique_id
		FROM recette_composition, commande
		WHERE (recette_composition.recette_id, commande.id) = (
			SELECT commande_composition.recette_id,commande_composition.commande_id
			FROM commande_composition
			WHERE commande_composition.id = variable);
	-- END MODIF
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
	OPEN mon_curseur;
		loop_curseur: LOOP      
			-- START MODIF
			FETCH mon_curseur INTO v_ingredient_id, v_quantite, v_boutique_id;

			UPDATE stock 
			SET quantite = quantite - v_quantite 
			WHERE ingredient_id = v_ingredient_id 
			AND boutique_id = v_boutique_id;

			-- END MODIF
			IF fin = 1 THEN LEAVE loop_curseur;	END IF;	
		END LOOP;
	CLOSE mon_curseur;
END|
DELIMITER ;


-- modification du statut de la commande en fonction de l'avancé de la préparation des pizzas
if all 1 THEN status = 1
if count(distinct) > 1 THEN status = 2
if au moins une entre = 2 THEN status = 2
if all 3 THEN status = 3


SELECT DISTINCT status_id 
FROM commande_composition
WHERE commande_id = 3

SELECT COUNT(DISTINCT status_id) 
FROM commande_composition
WHERE commande_id = 3

SELECT
CASE
	WHEN COUNT(DISTINCT status_id) > 1 THEN "en cours"
	WHEN status_id = 2 THEN "en preparation"
	WHEN status_id = 3 THEN "pret"
	ELSE "en attente"
END AS toto
FROM commande_composition
WHERE commande_id = 5;

SET @commid = 1;
SELECT
CASE
	WHEN COUNT(DISTINCT status_id) > 1 THEN "en preparation (diff)"
	WHEN status_id = 2 THEN "en preparation (tout)"
	WHEN status_id = 3 THEN "pret"
	ELSE "en attente"
END AS toto
FROM commande_composition
WHERE commande_id = @commid;



CREATE PROCEDURE update_etat_commande (IN var_commande_id INT)
	SELECT
	CASE
		WHEN COUNT(DISTINCT status_id) > 1 THEN  2 -- en preparation (different
		WHEN status_id = 2 THEN  2 -- en preparation (tout)
		WHEN status_id = 3 THEN  3 -- pret
		ELSE  1 -- en attente
	END AS status_id
	FROM commande_composition
	WHERE commande_id = var_commande_id;

CREATE PROCEDURE update_etat_commande (IN var_commande_id INT)
UPDATE commande SET status_id = (
    SELECT
	CASE
		WHEN COUNT(DISTINCT status_id) > 1 THEN  2 -- en preparation (different
		WHEN status_id = 2 THEN  2 -- en preparation (tout)
		WHEN status_id = 3 THEN  3 -- pret
		ELSE  1 -- en attente
	END AS status_id
	FROM commande_composition
	WHERE commande_id = var_commande_id
    ) WHERE id = var_commande_id;


-- si ma commande est livrée et payé je passe le status à terminé
if new.status_id = 6 AND new.paiement = 1
THEN
	BEGIN
	UPDATE commande SET status.id = 7 WHERE id = var_commande_id;
	END


SET @commid = 1;
UPDATE commande SET status_id = (
	SELECT 
		CASE
			WHEN status_id=5 AND paiement THEN 6
			ELSE status_id
		END AS new_status_id;
	FROM commande
	WHERE id = @commid;
) 
WHERE id = @commid;

SET @commid = 1;
UPDATE commande SET status_id = (
	SELECT 
		IF status_id=5 AND paiement THEN 6
			ELSE status_id;
	FROM commande
	WHERE id = @commid
) 
WHERE id = @commid;


CREATE TRIGGER `before_update_commande` BEFORE UPDATE ON `commande`
FOR EACH ROW 
BEGIN
	IF new.status_id = 5 AND new.paiement
		THEN SET new.status_id = 6;
	END IF;
END