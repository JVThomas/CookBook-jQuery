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
        injectText += '<h3><a href="/recipes/' + recipe["id"]+'">'+ recipe["name"] + '</a></h3>';
        injectText += '<div id ="details-' + recipe["id"] + '"></div>';
        injectText += '<a href="#" class = "btn ingredientsLink" data-id="' + recipe["id"] + '">Show Ingredients</a>';
        injectText += ' <a href="#" class = "btn contentLink" data-id="' + recipe["id"] + '">Show Instructions</a>';
      });
    }
    return injectText;
  }

  RecipeFormat.prototype.contentHtml = function(content){
    var injectText ='<p>'+ content+'</p>';
    return injectText;
  }
}