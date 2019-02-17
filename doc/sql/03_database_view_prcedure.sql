CREATE VIEW Stock_boutique_nord AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 1
ORDER BY nom;

CREATE VIEW Stock_boutique_sud AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 2
ORDER BY nom;

CREATE VIEW Stock_boutique_est AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 3
ORDER BY nom;

CREATE VIEW Stock_boutique_ouest AS
SELECT nom as Ingrédient, CONCAT(quantite, " ", unite) AS Quantité
FROM stock
JOIN ingredient ON stock.ingredient_id = ingredient.id
WHERE boutique_id = 4
ORDER BY nom;