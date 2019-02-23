
DELIMITER |
CREATE PROCEDURE retire_ligne_commande_stock (IN variable INT)
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


-- cas de mise à jour du stock à la préparation
CREATE TRIGGER `after_update_commande_composition` 
AFTER UPDATE ON `commande_composition` FOR EACH ROW 
CASE new.status_id 
	WHEN 2 THEN call retire_ligne_commande_stock (new.recette_id); 
	ELSE BEGIN END; 
END CASE;

-- cas de mise a jour du stock à la validation de commande
CREATE TRIGGER `after_insert_commande_composition` 
AFTER INSERT ON `commande_composition` FOR EACH ROW  
call retire_ligne_commande_stock (new.recette_id); 


