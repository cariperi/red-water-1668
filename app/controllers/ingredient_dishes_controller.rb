class IngredientDishesController < ApplicationController
  def create
    ingredient_dish = IngredientDish.create(ingredient_dish_params)
    redirect_to dish_path(ingredient_dish.dish)
  end

  private
  def ingredient_dish_params
    params.permit(:ingredient_id, :dish_id)
  end
end