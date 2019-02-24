-- test pour le status de la commande au global
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

-- la meme avec le retour des valeurs
SET @commid = 6;
SELECT
CASE
	WHEN COUNT(DISTINCT commande_composition.status_id) > 1 THEN 2
	WHEN commande_composition.status_id = 2 THEN 2
	WHEN commande_composition.status_id = 3 THEN 3
	ELSE 1
END AS Etat_commande
FROM commande_composition
WHERE commande_composition.commande_id = @commid;

-- la procedure complete
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

-- savoir si une commande est terminée
SET @commid = 6;
SELECT 
	CASE
    	WHEN status_id=5 AND paiement
        THEN "Termine"
      	ELSE "Encours"
    END AS etat
FROM commande
WHERE id = @commid;

-- retourne le status et le modifie si livré et payé
SET @commid = 4;
SELECT 
    CASE
        WHEN status_id=5 AND paiement THEN 6
        ELSE status_id
    END AS new_status_id
FROM commande
WHERE id = @commid;

















DELIMITER |
CREATE PROCEDURE affiche_commande_composition (IN var_commande_id INT)
BEGIN
    SELECT 
        recette_composition.ingredient_id, 
        recette_composition.quantite,
        commande.boutique_id
    FROM recette_composition, commande
    WHERE (recette_composition.recette_id, commande.id) = (
        SELECT commande_composition.recette_id,commande_composition.commande_id
        FROM commande_composition
        WHERE commande_composition.id = var_commande_id);
END|

CREATE PROCEDURE retire_ligne_commande_stock (IN var_commande_id INT)
BEGIN
	DECLARE fin TINYINT DEFAULT 0; 
	-- START MODIF
	DECLARE v_ingredient_id, v_quantite, v_boutique_id INT;
	DECLARE mon_curseur CURSOR FOR
		(CALL affiche_commande_composition(var_commande_id));
	-- END MODIF
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
	OPEN mon_curseur;
		loop_curseur: LOOP 
            IF fin = 1 THEN LEAVE loop_curseur;	END IF;     
			-- START MODIF
			FETCH mon_curseur INTO v_ingredient_id, v_quantite, v_boutique_id;

			UPDATE stock 
			SET quantite = quantite - v_quantite 
			WHERE ingredient_id = v_ingredient_id 
			AND boutique_id = v_boutique_id;

			-- END MODIF
		END LOOP;
	CLOSE mon_curseur;
END|
DELIMITER ;