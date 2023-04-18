class Dish < ApplicationRecord
  validates_presence_of :name, :description

  belongs_to :chef
  has_many :ingredient_dishes
  has_many :ingredients, through: :ingredient_dishes

  def get_calorie_count
    ingredients.sum(:calories)
  end

  def chef_name
    chef.name
  end
end