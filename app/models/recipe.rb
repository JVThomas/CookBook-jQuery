class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :delete_all
  
  validates :content, presence: true
  validates :name, presence: true

  # fields_for recipe_ingredients
  def recipe_ingredients_attributes=(attributes)
    valid_attributes(attributes)
    if !errors.any?
      attributes.each do |i,attribute|
        @ingredient = Ingredient.find_or_create_by(name: attribute[:ingredient_name].downcase.titlecase)
        if self.recipe_ingredients[i.to_i].nil?
          @recipe_ingredient = self.recipe_ingredients.build(quantity: attribute[:quantity], ingredient_id: @ingredient.id)
        else
          self.recipe_ingredients[i.to_i].update(ingredient_id: @ingredient.id, quantity: attribute[:quantity])
        end
      end
    end
  end

  def valid_attributes(attributes)
    attributes.each do |num,hash|
      hash.each do |attribute, value|
        errors.add(attribute, "must be filled in") if value.blank? && errors[attribute].empty?
      end
    end
  end

  def user_name
    user.name
  end

  def self.search_by_ingredient(name)
    joins(:ingredients).where(ingredients:{name: name.downcase.titlecase}).group('recipes.id')
  end

end
