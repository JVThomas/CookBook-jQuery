class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  validates :content, presence: true

  def recipe_name
    recipe.name
  end

  def user_name
    user.name
  end
end
