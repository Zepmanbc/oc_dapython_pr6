DROP DATABASE IF EXISTS oc_dapython_pr6;

CREATE DATABASE oc_dapython_pr6 CHARACTER SET 'utf8';

USE oc_dapython_pr6;

CREATE TABLE users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    boutique_id INT UNSIGNED DEFAULT NULL,
    role_id INT UNSIGNED NOT NULL,
    login VARCHAR(255) NOT NULL,
    telephone VARCHAR(12) NOT NULL,
    password CHAR(64) NOT NULL,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    email VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE boutique (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    horaires TINYTEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE commande (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_id INT UNSIGNED NOT NULL,
    boutique_id INT UNSIGNED NOT NULL,
    status_id INT UNSIGNED NOT NULL DEFAULT '1',
    paiement_type_id INT UNSIGNED NOT NULL,
    date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    paiement BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id),
    INDEX ind_boutique_status (boutique_id, status_id)
);

CREATE TABLE commande_composition (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    commande_id INT UNSIGNED NOT NULL,
    recette_id INT UNSIGNED NOT NULL,
    status_id INT UNSIGNED NOT NULL DEFAULT '1',
    PRIMARY KEY (id)
);

CREATE TABLE ingredient (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    unite VARCHAR(8) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE paiement_type (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designation VARCHAR(15) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE recette (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    designation_commerciale text,
    designation_technique text,
    prix float(4,2),
    PRIMARY KEY (id)
);

CREATE TABLE recette_composition (
    recette_id INT UNSIGNED NOT NULL,
    ingredient_id INT UNSIGNED NOT NULL,
    quantite int(4) NOT NULL,
    PRIMARY KEY (recette_id, ingredient_id)
);

CREATE TABLE role (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designation VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE status_commande (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designation VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE status_composition (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designation VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE stock (
  ingredient_id INT UNSIGNED NOT NULL,
  boutique_id INT UNSIGNED NOT NULL,
  quantite int(12) NOT NULL,
  PRIMARY KEY (ingredient_id, boutique_id)
);

--
-- CONTRAINTES;
--

ALTER TABLE users 
ADD CONSTRAINT fk_users_boutique_id FOREIGN KEY (boutique_id) REFERENCES boutique(id) ON DELETE SET NULL;

ALTER TABLE users 
ADD CONSTRAINT fk_users_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_client_id FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_boutique_id FOREIGN KEY (boutique_id) REFERENCES boutique(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_status_commande_id FOREIGN KEY (status_id) REFERENCES status_commande(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_paiement_type_id FOREIGN KEY (paiement_type_id) REFERENCES paiement_type(id) ON DELETE RESTRICT;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_commande_id FOREIGN KEY (commande_id) REFERENCES commande(id) ON DELETE CASCADE;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_recette_id FOREIGN KEY (recette_id) REFERENCES recette(id) ON DELETE RESTRICT;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_status_composition_id FOREIGN KEY (status_id) REFERENCES status_composition(id) ON DELETE RESTRICT;

ALTER TABLE stock 
ADD CONSTRAINT fk_stock_ingredient_id FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE;

ALTER TABLE stock 
ADD CONSTRAINT fk_stock_boutique_id FOREIGN KEY (boutique_id) REFERENCES boutique(id) ON DELETE CASCADE;

ALTER TABLE recette_composition 
ADD CONSTRAINT fk_recette_composition_recette_id FOREIGN KEY (recette_id) REFERENCES recette(id) ON DELETE CASCADE;

ALTER TABLE recette_composition 
ADD CONSTRAINT fk_recette_composition_ingredient_id FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE;

--
-- TRIGGERS;
--


-- Création du stock lors de la création d'une boutique
CREATE TRIGGER after_insert_boutique AFTER INSERT ON boutique FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT ingredient.id as ingredient_id, 
    new.id as boutique_id,
    0 as quantity
FROM ingredient;


-- suppression du stock en cas de suppression d'une boutique
CREATE TRIGGER after_delete_boutique AFTER DELETE ON boutique FOR EACH ROW 
DELETE FROM stock WHERE boutique_id = old.id;


-- ajout d'un ingrédtien dans le stock de chaque boutique lors de la création d'un nouvel ingrédient
CREATE TRIGGER after_insert_ingredient AFTER INSERT ON ingredient FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT new.id as ingredient_id, 
    boutique.id as boutique_id,
    0 as quantity
FROM boutique;


-- suppression de l'ingrédient dans les stock de toutes les boutique en cas de suppression d'un ingrédient
CREATE TRIGGER after_delete_ingredient AFTER DELETE ON ingredient FOR EACH ROW 
DELETE FROM stock WHERE ingredient_id = old.id;


-- procedure qui met à jour le status de la commande en fonction du status de chaque pizza
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


-- procedure qui affiche les ingrédients à retirer dans une commande_composition
-- A essayer d'utiliser dans la procédure suivante, mais le call ne fonctionne pas...
CREATE PROCEDURE affiche_commande_composition (IN var_commande_id INT)
    SELECT 
        recette_composition.ingredient_id, 
        recette_composition.quantite,
        commande.boutique_id
    FROM recette_composition, commande
    WHERE (recette_composition.recette_id, commande.id) = (
        SELECT commande_composition.recette_id,commande_composition.commande_id
        FROM commande_composition
        WHERE commande_composition.id = var_commande_id);


-- procedure qui retire les ingrédients d'une recette dans le stock (infos récupéréer sur la commande_composition)
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
            IF fin = 1 THEN LEAVE loop_curseur;	END IF; 
			UPDATE stock 
			SET quantite = quantite - v_quantite 
			WHERE ingredient_id = v_ingredient_id 
			AND boutique_id = v_boutique_id;

			-- END MODIF
		END LOOP;
	CLOSE mon_curseur;
END|
DELIMITER ;

-- cas de mise a jour du stock à la validation de commande
-- CREATE TRIGGER `after_insert_commande_composition` 
-- AFTER INSERT ON `commande_composition` FOR EACH ROW  
-- call retire_ligne_commande_stock (new.recette_id);
-- CREATE TRIGGER `after_update_commande_composition` AFTER UPDATE ON `commande_composition`FOR EACH ROW
-- CALL update_etat_commande(new.commande_id);

-- cas de mise à jour du stock lorsque la pizza passe en preparation
DELIMITER |
CREATE TRIGGER `after_update_commande_composition` AFTER UPDATE ON `commande_composition`
FOR EACH ROW 
BEGIN
    CASE 
        WHEN new.status_id = 2 
            THEN call retire_ligne_commande_stock(new.id); 
        ELSE BEGIN END; 
    END CASE;
    CALL update_etat_commande(new.commande_id);
END|
DELIMITER ;

-- mise à jour de la commande en Terminé quand la commande est livrée et payée
DELIMITER |
CREATE TRIGGER `before_update_commande` BEFORE UPDATE ON `commande`
FOR EACH ROW 
BEGIN
	IF new.status_id = 5 AND new.paiement
		THEN SET new.status_id = 6;
	END IF;
END|
DELIMITER ;