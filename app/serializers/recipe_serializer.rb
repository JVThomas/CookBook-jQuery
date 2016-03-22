class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :content, :name
  has_many :recipe_ingredients
end
