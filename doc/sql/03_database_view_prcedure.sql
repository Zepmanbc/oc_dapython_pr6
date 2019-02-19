USE oc_dapython_pr6;

CREATE VIEW v_stock_boutique_nord AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 1
ORDER BY nom;

CREATE VIEW v_stock_boutique_sud AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 2
ORDER BY nom;

CREATE VIEW v_stock_boutique_est AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 3
ORDER BY nom;

CREATE VIEW v_stock_boutique_ouest AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 4
ORDER BY nom;

CREATE VIEW v_commandes_boutique_nord AS
SELECT 
CONCAT(authentification.prenom, " ", authentification.nom) AS Client,
status.designation AS Status,
paiement_type.designation AS "Mode de paiement",
IF(commande.paiement, "OK", "...") AS Paiement
FROM commande 
JOIN authentification ON authentification.id = commande.client_id
JOIN status ON status.id = commande.status_id
JOIN paiement_type ON paiement_type.id = paiement_type_id
WHERE commande.boutique_id = 1
ORDER BY status.id;


-- SELECT CONCAT("Recette : ",recette.nom) AS "Liste des ingrédients de la recette"
-- FROM recette
-- WHERE recette.id = 1
-- UNION ALL
-- SELECT CONCAT(recette_composition.quantite, " ", ingredient.unite, " de ", ingredient.nom)
-- FROM recette_composition 
-- JOIN ingredient ON ingredient.id = recette_composition.ingredient_id
-- JOIN recette ON recette.id = recette_composition.recette_id
-- WHERE recette.id = 1;


--
-- PROCEDURES
--

DELIMITER |
CREATE PROCEDURE pr_voir_recette (IN var_recette_id INT)
BEGIN
    SELECT CONCAT(quantite, " ", unite, " de ", nom) AS "Liste des ingrédients de la recette" 
    FROM recette_composition 
    JOIN ingredient ON ingredient.id = recette_composition.ingredient_id 
    WHERE recette_id = var_recette_id;
END|
DELIMITER ;