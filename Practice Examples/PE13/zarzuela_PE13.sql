-- ---------------------------------------------------------------------------------

-- File       : zarzuela_PE13.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for finding recipes and ingredients from the recipe database.
--
-- Notes      :
--    First run the script PE13.sql to create the ingredients database and the
--    collection of tables: ingredientList, ingredient, nutrition, recipe, and step.

-- ---------------------------------------------------------------------------------


-- Automaticlly pre-runs the PE13.sql script, remove if pre-running script manually
source C:\Users\briza\Documents\Academics\2020 Spring\Data Modeling\Practice Examples\PE13\PE13.sql;


-- Open the database
use recipes;


-- ---------------------------------------------------------------------------------
--  1. Show the recipes from Mom stored in the database
select name
from recipe
where source like 'mom';


-- ---------------------------------------------------------------------------------
--  2. Find the names of recipes that have fewer than 800 calories
select recipe.name
from recipe inner join nutrition
on recipe.RecipeId = nutrition.recipeId
where nutrition.unit like 'calories' and
      nutrition.quantity < 800;


-- ---------------------------------------------------------------------------------
--  3. Create a shopping list of the ingredients for Beef Paramesan
select ingredient.name, ingredientList.quantity
from (recipe inner join ingredientList
on recipe.RecipeId = ingredientList.recipeId) inner join ingredient
on ingredientList.IngredientId = ingredient.IngredientId
where recipe.name like '%Beef Parmesan%';


-- ---------------------------------------------------------------------------------
--  4. Find the names of recipes that are vegetarian, ie. that don't contain beef,
--     pork, chicken, or lamb.
select recipe.name
from recipe
where recipe.RecipeId not in
  (select ingredientList.recipeId
  from ingredientList inner join ingredient
  on ingredientList.IngredientId = ingredient.IngredientId
  where ingredient.type in ('beef', 'pork', 'chicken', 'lamb'));


-- ---------------------------------------------------------------------------------
--  5. Find the names of fish recipes that have fewer than 700 calories per serving.
select recipe.name
from recipe
where recipe.recipeId in
  (select ingredientList.recipeId
  from (ingredientList inner join ingredient
  on ingredientList.IngredientId = ingredient.IngredientId) inner join nutrition
  on ingredientList.recipeId = nutrition.recipeId
  where ingredient.type like 'fish' and
        nutrition.unit like 'calories' and
        nutrition.quantity < 700);



