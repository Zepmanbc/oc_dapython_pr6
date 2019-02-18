USE oc_dapython_pr6;

--
--  BASIC FUNCTIONALITIES;
--

INSERT INTO `role` (`id`, `designation`) VALUES
(1, 'directeur'),
(2, 'pizzaiolo'),
(3, 'gestionnaire de stock'),
(4, 'gestionnaire de commande'),
(5, 'client');

INSERT INTO `status` (`id`, `designation`) VALUES
(1, 'validé'),
(2, 'en préparation'),
(3, 'prêt'),
(4, 'en livraison'),
(5, 'livré'),
(6, 'terminé');

INSERT INTO `paiement_type` (`id`, `designation`) VALUES
(1, 'liquide'),
(2, 'carte bancaire'),
(3, 'chèque'),
(4, 'en ligne');

--
--  STORES;
--

INSERT INTO `boutique` (`nom`, `adresse`, `horaires`) VALUES
('Boutique du nord', '12 rue de la frite, 59000 Lille', '12h-14h\r\n18h-23h\r\n7j/7'),
('Boutique du sud', '3 rue de la cigale, 13000 Marseille', '12h-15h\r\n19h-22h\r\n7j/7'),
('Boutique de l''est', '44 rue de la choucroute, 67000 Strasbourg', '11h-13h\r\n18h-22h\r\n7j/7'),
('Boutique de l''ouest', '78 rue de la mouette, 29200 Brest', '12h-13h\r\n18h-23h\r\n7j/7');

--
--  RECIPES AND ITEMS;
--

INSERT INTO `recette` (`id`, `nom`, `designation_commerciale`, `designation_technique`, `prix`) VALUES
(1, 'Royale', 'Coulis de tomate, mozzarella, champignons de Paris frais, oignons, jambon supérieur, lardons fumés', 'étaler la pâte\r\nmettre les ingrédients\r\nmettre au four\r\nsortir du four', 15.90),
(2, '4 Fromages', 'Coulis de tomate, mozzarella, cheddar, fromage de chèvre, reblochon, crème fraîche', 'étaler la pâte\r\nmettre les ingrédients\r\nmettre au four\r\nsortir du four\r\naérer car ça sent fort le fromage', 16.90),
(3, 'Primavera', 'Tomate fraîche, mozzarella di latte di Bufala Galbani, roquette, tomates marinées, belles tranches de jambon cru', 'étaler la pâte\r\nmettre les ingrédients sauf la salade\r\nmettre au four\r\nsortir du four\r\nrajouter la salade', 18.90);

INSERT INTO `ingredient` (`id`, `nom`, `unite`) VALUES
(1, 'Pate', 'boule'),
(2, 'Coulis de tomate', 'cl'),
(3, 'Mozzarella', 'g'),
(4, 'Champignon de Paris', 'g'),
(5, 'Oignon', 'g'),
(6, 'Jambon', 'g'),
(7, 'Lardon', 'g'),
(8, 'Cheddar', 'g'),
(9, 'Fromage de chèvre', 'g'),
(10, 'Reblochon', 'g'),
(11, 'Créme fraiche', 'cl'),
(12, 'Tomate fraiche', 'g'),
(13, 'Roquette', 'g'),
(14, 'Tomate mariné', 'g'),
(15, 'Saumon fumé', 'g'),
(16, 'Oeuf', 'unité');

INSERT INTO `recette_composition` (`recette_id`, `ingredient_id`, `quantite`) VALUES
(1, 1, 1),
(1, 2, 50),
(1, 3, 30),
(1, 4, 25),
(1, 5, 12),
(1, 6, 40),
(1, 7, 20),
(2, 1, 1),
(2, 3, 25),
(2, 8, 25),
(2, 9, 25),
(2, 10, 25),
(2, 11, 15),
(3, 1, 1),
(3, 3, 20),
(3, 12, 20),
(3, 13, 10),
(3, 14, 5),
(3, 16, 1);

--
--  USERS SAMPLE;
--

-- INSERT INTO `authentification` (`id`, `boutique_id`, `role_id`, `login`, `telephone`, `password`, `nom`, `prenom`, `email`) VALUES
-- (1, NULL, 1, 'directeur', '', 'directeur_password', '', '', ''),
-- (2, 1, 2, 'Piz_nord', '', '', '', '', ''),
-- (3, 1, 3, 'stock_nord', '', '', '', '', ''),
-- (4, 1, 4, 'Commande_nord', '', '', '', '', ''),
-- (5, 2, 2, 'piz_sud', '', '', '', '', ''),
-- (6, 2, 3, 'stock_sud', '', '', '', '', ''),
-- (7, 2, 3, 'cmd_sud', '', '', '', '', ''),
-- (8, 3, 2, 'piz_est', '', '', '', '', ''),
-- (9, 3, 3, 'stock_est', '', '', '', '', ''),
-- (10, 3, 3, 'cmd_est', '', '', '', '', ''),
-- (11, 4, 2, 'piz_ouest', '', '', '', '', ''),
-- (12, 4, 3, 'stock_ouest', '', '', '', '', ''),
-- (13, 4, 3, 'cmd_ouest', '', '', '', '', ''),
-- (14, 1, 5, 'client1_nord', '0320123456', 'biloute', 'Jean', 'Du Nord', 'jean.dunord@nordnet.com'),
-- (15, 2, 5, 'client_sud', '0494123456', 'cigale', 'Jean', 'Du Sud', 'jean.dusud@figalou.net'),
-- (16, 3, 5, 'client_est', '0312345678', 'flamenkuche', 'Jean', 'De Lest', 'jean.delest@saucisse.com'),
-- (17, 4, 5, 'client_ouest', '0212345678', 'bateau', 'Jean', 'De Louest', 'jean.delouest@mouette.net');

