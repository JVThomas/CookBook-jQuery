class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :recipe_ingredients
end
