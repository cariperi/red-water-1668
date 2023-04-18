require 'rails_helper'

RSpec.describe 'the dish show page' do

  before(:each) do
    @chef_1 = Chef.create!(name: "Chef 1")
    @chef_2 = Chef.create!(name: "Chef 2")

    @dish_1 = @chef_1.dishes.create!(name: "Dish 1", description: "ABC")
    @dish_2 = @chef_1.dishes.create!(name: "Dish 2", description: "DEF")

    @dish_3 = @chef_2.dishes.create!(name: "Dish 3", description: "GHI")
    @dish_4 = @chef_2.dishes.create!(name: "Dish 4", description: "XYZ")

    @ingredient_1 = Ingredient.create!(name: "Sugar", calories: 10)
    @ingredient_2 = Ingredient.create!(name: "Salt", calories: 20)
    @ingredient_3 = Ingredient.create!(name: "Pepper", calories: 50)

    IngredientDish.create!(ingredient_id: @ingredient_1.id, dish_id: @dish_1.id)
    IngredientDish.create!(ingredient_id: @ingredient_1.id, dish_id: @dish_3.id)
    IngredientDish.create!(ingredient_id: @ingredient_2.id, dish_id: @dish_2.id)
    IngredientDish.create!(ingredient_id: @ingredient_2.id, dish_id: @dish_1.id)
    IngredientDish.create!(ingredient_id: @ingredient_3.id, dish_id: @dish_4.id)
  end

  it 'should display the name, description, and ingredients for the dish' do
    visit dish_path(@dish_1)

    expect(page).to have_content("Dish Name: #{@dish_1.name}")
    expect(page).to have_content("Description: #{@dish_1.description}")

    expect(page).to have_content("Ingredients for this Dish:")

    within("#ingredient-#{@ingredient_1.id}") do
      expect(page).to have_content("Ingredient Name: #{@ingredient_1.name}")
    end

    within("#ingredient-#{@ingredient_2.id}") do
      expect(page).to have_content("Ingredient Name: #{@ingredient_2.name}")
    end

    expect(page).to_not have_content("#{@ingredient_3.name}")
  end

  it 'should display a total calorie count for the dish' do
    visit dish_path(@dish_1)

    expect(page).to have_content("Total Calories: 30")
  end

  it 'should display the chefs name' do
    visit dish_path(@dish_1)

    expect(page).to have_content("Chef Name: #{@chef_1.name}")
    expect(page).to_not have_content("Chef Name: #{@chef_2.name}")
  end
end
