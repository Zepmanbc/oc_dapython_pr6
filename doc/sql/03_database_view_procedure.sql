USE oc_dapython_pr6;

--
--  VIEWS
--

-- Affiche le stock actuel de la boutique
CREATE VIEW v_1_stock_boutique_nord AS
SELECT nom as Ingrédient, CONCAT(quantite, ' ', unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 1
ORDER BY nom;

-- Affiche le stock actuel de la boutique
CREATE VIEW v_2_stock_boutique_sud AS
SELECT nom as Ingrédient, CONCAT(quantite, ' ', unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 2
ORDER BY nom;

-- Affiche le stock actuel de la boutique
CREATE VIEW v_3_stock_boutique_est AS
SELECT nom as Ingrédient, CONCAT(quantite, ' ', unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 3
ORDER BY nom;

-- Affiche le stock actuel de la boutique
CREATE VIEW v_4_stock_boutique_ouest AS
SELECT nom as Ingrédient, CONCAT(quantite, ' ', unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 4
ORDER BY nom;

-- Affiche les commandes de la boutique
CREATE VIEW v_1_commandes_boutique_nord AS
SELECT 
commande.id AS numero,
CONCAT(users.prenom, ' ', users.nom) AS Client,
status_commande.designation AS Status_commande,
paiement_type.designation AS "Mode de paiement",
CASE WHEN commande.paiement THEN 'OK' ELSE '...' END
FROM commande 
JOIN users ON users.id = commande.client_id
JOIN status_commande ON status_commande.id = commande.status_id
JOIN paiement_type ON paiement_type.id = paiement_type_id
WHERE commande.boutique_id = 1
ORDER BY commande.id;
-- Affiche les commandes de la boutique
CREATE VIEW v_2_commandes_boutique_sud AS
SELECT 
commande.id AS numero,
CONCAT(users.prenom, ' ', users.nom) AS Client,
status_commande.designation AS Status_commande,
paiement_type.designation AS "Mode de paiement",
CASE WHEN commande.paiement THEN 'OK' ELSE '...' END
FROM commande 
JOIN users ON users.id = commande.client_id
JOIN status_commande ON status_commande.id = commande.status_id
JOIN paiement_type ON paiement_type.id = paiement_type_id
WHERE commande.boutique_id = 2
ORDER BY commande.id;
-- Affiche les commandes de la boutique
CREATE VIEW v_3_commandes_boutique_est AS
SELECT 
commande.id AS numero,
CONCAT(users.prenom, ' ', users.nom) AS Client,
status_commande.designation AS Status_commande,
paiement_type.designation AS "Mode de paiement",
CASE WHEN commande.paiement THEN 'OK' ELSE '...' END
FROM commande 
JOIN users ON users.id = commande.client_id
JOIN status_commande ON status_commande.id = commande.status_id
JOIN paiement_type ON paiement_type.id = paiement_type_id
WHERE commande.boutique_id = 3
ORDER BY commande.id;
-- Affiche les commandes de la boutique
CREATE VIEW v_4_commandes_boutique_ouest AS
SELECT 
commande.id AS numero,
CONCAT(users.prenom, ' ', users.nom) AS Client,
status_commande.designation AS Status_commande,
paiement_type.designation AS "Mode de paiement",
CASE WHEN commande.paiement THEN 'OK' ELSE '...' END
FROM commande 
JOIN users ON users.id = commande.client_id
JOIN status_commande ON status_commande.id = commande.status_id
JOIN paiement_type ON paiement_type.id = paiement_type_id
WHERE commande.boutique_id = 4
ORDER BY commande.id;
--
-- PROCEDURES
--

-- voir_recette
-- permet d'afficher les ingédients et la quantité pour une recette donnée

DELIMITER |
CREATE PROCEDURE voir_recette (IN var_recette_id INT)
BEGIN
    SELECT CONCAT(quantite, ' ', unite, " de ", nom) AS "Liste des ingrédients de la recette" 
    FROM recette_composition 
    JOIN ingredient ON ingredient.id = recette_composition.ingredient_id 
    WHERE recette_id = var_recette_id
	UNION
	SELECT designation_technique FROM recette WHERE recette.id = var_recette_id;
END|
DELIMITER ;


-- entete_commande
-- retourne les informations sur une commande
-- Date (JJ/MM/AAA) | Client (prenom nom) | prix total | paiement (type de paiment + OK ou ...)

DELIMITER |
CREATE PROCEDURE entete_commande(IN `var_recette_id` INT) 
BEGIN
	SELECT 
		LEFT(commande.date, 10) AS Date, 
		CONCAT(users.prenom, ' ', users.nom) AS Client, 
		status_commande.designation AS Status, 
		(SELECT SUM(recette.prix)
			FROM recette
			RIGHT JOIN commande_composition ON commande_composition.recette_id = recette.id
			WHERE commande_composition.commande_id = commande.id
		) AS prix, 
		CONCAT(paiement_type.designation, IF(paiement," OK", " ...")) AS Paiement
	FROM commande
	JOIN users ON users.id = commande.client_id
	JOIN status_commande ON status_commande.id = commande.status_id
	JOIN paiement_type ON paiement_type.id = commande.paiement_type_id
	WHERE commande.id = var_recette_id;
END|
DELIMITER ;

-- corps_commande
-- affiche la liste des pizzas dans une commande
-- nom de la recette | status de la pizza | prix de la pizza

DELIMITER |
CREATE PROCEDURE corps_commande(IN `var_recette_id` INT) 
BEGIN
	SELECT 
		commande_composition.id AS cc_id, 
		recette.nom, 
		status_composition.designation, 
		recette.prix
	FROM commande_composition
	JOIN recette ON recette.id = commande_composition.recette_id
	JOIN status_composition ON status_composition.id = commande_composition.status_id
	WHERE commande_composition.commande_id = var_recette_id
	ORDER BY recette.nom;
END|
DELIMITER ;

-- retourne la quantite possible de recette par une boutique
DELIMITER |
CREATE PROCEDURE recette_possible(IN `var_boutique_id` INT) 
BEGIN
	SELECT 
		recette.nom,
		MIN(FLOOR(stock.quantite / recette_composition.quantite)) AS qte_possible
	FROM stock
	JOIN boutique ON boutique.id = stock.boutique_id
	JOIN recette_composition ON recette_composition.ingredient_id = stock.ingredient_id
	JOIN ingredient ON ingredient.id = stock.ingredient_id
	JOIN recette ON recette.id = recette_composition.recette_id
	WHERE boutique.id = var_boutique_id GROUP BY recette_id;
END|
DELIMITER ;

-- vue globale des recettes dispo sur toutes les boutiques
CREATE VIEW v_0_recettes_possible AS
SELECT 
	boutique.id as boutique,
    recette.nom,
	MIN(FLOOR(stock.quantite / recette_composition.quantite)) AS qte_possible
FROM stock
JOIN boutique ON boutique.id = stock.boutique_id
JOIN recette_composition ON recette_composition.ingredient_id = stock.ingredient_id
JOIN ingredient ON ingredient.id = stock.ingredient_id
JOIN recette ON recette.id = recette_composition.recette_id
GROUP BY boutique.id, recette_id;

-- vue globale du chiffre d'affaire de la journée (en temps réél)
CREATE VIEW v_0_chiffre_d_affaire_journée AS
SELECT 
	boutique.id AS boutique, 
	SUM(recette.prix) as total
FROM recette
JOIN commande_composition ON commande_composition.recette_id = recette.id
JOIN commande ON commande.id = commande_composition.commande_id
JOIN boutique ON boutique.id = commande.boutique_id
WHERE commande.paiement AND DATE(commande.date) = CURDATE()
GROUP BY boutique.id;
