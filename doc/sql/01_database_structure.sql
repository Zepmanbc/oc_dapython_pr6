DROP DATABASE IF EXISTS oc_dapython_pr6;

CREATE DATABASE oc_dapython_pr6 CHARACTER SET 'utf8';

USE oc_dapython_pr6;

CREATE TABLE authentification (
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
    designation VARCHAR(10) NOT NULL,
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

CREATE TABLE status (
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

ALTER TABLE authentification 
ADD CONSTRAINT fk_authentification_boutique_id FOREIGN KEY (boutique_id) REFERENCES boutique(id) ON DELETE SET NULL;

ALTER TABLE authentification 
ADD CONSTRAINT fk_authentification_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_client_id FOREIGN KEY (client_id) REFERENCES authentification(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_boutique_id FOREIGN KEY (boutique_id) REFERENCES boutique(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_status_id FOREIGN KEY (status_id) REFERENCES status(id) ON DELETE RESTRICT;

ALTER TABLE commande 
ADD CONSTRAINT fk_commande_paiement_type_id FOREIGN KEY (paiement_type_id) REFERENCES paiement_type(id) ON DELETE RESTRICT;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_commande_id FOREIGN KEY (commande_id) REFERENCES commande(id) ON DELETE CASCADE;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_recette_id FOREIGN KEY (recette_id) REFERENCES recette(id) ON DELETE RESTRICT;

ALTER TABLE commande_composition 
ADD CONSTRAINT fk_commande_composition_status_id FOREIGN KEY (status_id) REFERENCES status(id) ON DELETE RESTRICT;

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

CREATE TRIGGER after_insert_boutique AFTER INSERT ON boutique FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT ingredient.id as ingredient_id, 
    new.id as boutique_id,
    0 as quantity
FROM ingredient;

CREATE TRIGGER after_delete_boutique AFTER DELETE ON boutique FOR EACH ROW 
DELETE FROM stock WHERE boutique_id = old.id;

CREATE TRIGGER after_insert_ingredient AFTER INSERT ON ingredient FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT new.id as ingredient_id, 
    boutique.id as boutique_id,
    0 as quantity
FROM boutique;

CREATE TRIGGER after_delete_ingredient AFTER DELETE ON ingredient FOR EACH ROW 
DELETE FROM stock WHERE ingredient_id = old.id;