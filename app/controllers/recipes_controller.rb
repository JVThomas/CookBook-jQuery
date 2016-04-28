class RecipesController < ApplicationController
  before_action :require_login, only:[:new, :create, :edit, :update, :destroy]
  before_action :set_recipe, only:[:edit, :update, :show, :destroy]
  before_action :params_check, only:[:new, :create]
  before_action :set_user, only:[:index,:show]

  def new
    @recipe = Recipe.new  
    3.times do
      @recipe.recipe_ingredients.build
    end
  end
  
  def index
    #condition for user/recipe index
    if !!@user
      @recipes = Recipe.where(user_id:@user.id)
    #conditions for recipes index
    else 
      # condition for recipes index based on search params
      if !!params[:ingredient_name]
        @recipes = Recipe.search_by_ingredient(params[:ingredient_name])
        render json: @recipes
      # condition for initial load of recipes index
      else 
        @recipes = Recipe.all
      end
    end
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if !@recipe.errors.any? && @recipe.save 
      flash[:notice] = "Recipe successfully submited"
      redirect_to @recipe
    else
     #had to do this to maintain consistency of fields. 
     #Depending on user input, either no fields or an addiional 3 fields were added without this block
     @recipe.recipe_ingredients = [] 
      3.times do
        @recipe.recipe_ingredients.build
      end
      render :new
    end
  end

  def show
    @comment = Comment.new
    if !!@user && @user.id != @recipe.user.id
      flash[:alert] = "Recipe does not belong to specified user"
      home_redirect
    else
      respond_to do |format|
        format.html{render :show}
        format.json{render json: @recipe}
      end
    end
  end

  def edit
    authorize(@recipe)
  end
    
  def update
    authorize(@recipe)
    @recipe.attributes = recipe_params
    if !@recipe.errors.any? && @recipe.update(recipe_params)
      flash[:notice] = "Recipe successfully submited"
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    authorize(@recipe)
    @recipe.destroy
    flash[:notice] = "Recipe successfully deleted"
    redirect_to user_path(current_user)
  end
  
  private

    def recipe_params
      params.require(:recipe).permit(:name, :content, :recipe_ingredients_attributes => [:ingredient_name, :quantity])
    end

    def set_recipe
      if Recipe.exists?(params[:id])
        @recipe = Recipe.find(params[:id])
      else
        flash[:alert] = "Recipe does not exist"
        home_redirect
      end
    end

    
end