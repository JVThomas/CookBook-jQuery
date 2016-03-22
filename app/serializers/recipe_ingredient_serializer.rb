class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  has_one :ingredient
end
