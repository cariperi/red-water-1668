class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def get_ingredient_names
    ingredients.order(:name).distinct.pluck(:name).to_sentence
  end

  def most_popular_3_ingredients
    ingredients.select('ingredients.*, count(dishes)').joins(:dishes).group(:id).order(count: :desc).limit(3).pluck(:name)
  end
end
