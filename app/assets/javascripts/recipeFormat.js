function RecipeFormat(){
  
  RecipeFormat.prototype.ingredientsHtml = function(recipeIngredients){
    var injectText = ""
    recipeIngredients.forEach(function(details){
      injectText += "<p><strong>Ingredient:</strong> " + details["ingredient"]["name"]+ " /<strong> Quantity:</strong> " + details["quantity"] + "</p>";
    });
    return injectText;
  }

  RecipeFormat.prototype.recipeHtml = function(recipes){
    var injectText = "";
    if (recipes.length === 0){
      injectText = "No results found";
    }
    else{
      recipes.forEach(function(recipe){
        injectText += '<div class = "recipeItem">'
                    + '<h3><a href="/recipes/' + recipe["id"]+'">'+ recipe["name"] + '</a></h3>'
                    + '<div id ="details-' + recipe["id"] + '"></div>'
                    + '<a href="#" class = "btn ingredientsLink" data-id="' + recipe["id"] + '">Show Ingredients</a>'
                    + ' <a href="#" class = "btn contentLink" data-id="' + recipe["id"] + '">Show Instructions</a></div>';
      });
    }
    return injectText;
  }

  RecipeFormat.prototype.contentHtml = function(content){
    var injectText ='<p>'+ content+'</p>';
    return injectText;
  }

  RecipeFormat.prototype.addNewIngredient = function(index){
    var injectText  = '<div class = "recipe_ingredient">'
                    + '<div><label for="recipe_recipe_ingredients_attributes_' + index + '_Ingredient name:">Ingredient name:</label>'
                    + '<input type="text" name="recipe[recipe_ingredients_attributes]['+ index +'][ingredient_name]" id="recipe_recipe_ingredients_attributes_'+ index +'_ingredient_name">'
                    + '<br><br></div>'
                    + '<div><label for="recipe_recipe_ingredients_attributes_'+ index +'_Quantity:">Quantity:</label>'
                    + '<input type="number" name="recipe[recipe_ingredients_attributes]['+ index + '][quantity]" id="recipe_recipe_ingredients_attributes_0_quantity">'
                    + '<br><br></div>';
    return injectText;
  }
}