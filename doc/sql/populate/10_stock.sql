USE oc_dapython_pr6;

-- Ajout de stock pour 10 pizza de chaque dans chaque boutique

UPDATE stock 
     SET stock.quantite = (
          SELECT SUM(recette_composition.quantite * 10)
          FROM recette_composition 
          WHERE recette_composition.ingredient_id = stock.ingredient_id
          GROUP BY recette_composition.ingredient_id
     )
 WHERE EXISTS (
      SELECT * 
      FROM recette_composition 
      WHERE recette_composition.ingredient_id = stock.ingredient_id
 );