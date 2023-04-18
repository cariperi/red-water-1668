class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def get_ingredient_names
    ingredients.order(:name).distinct.pluck(:name).to_sentence
  end
end