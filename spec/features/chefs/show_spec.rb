require 'rails_helper'

RSpec.describe 'the chef show page' do
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

  describe "user story 3" do
    it 'shows a link to a chef_ingredients index page' do
      visit chef_path(@chef_1)

      expect(page).to have_content("Chef Show Page for Chef 1")
      expect(page).to have_link("View All Ingredients")
    end

    it 'the link goes to a chefs ingredients index page with a unique list of the names of all ingredients used by the chef' do
      visit chef_path(@chef_1)
      click_link "View All Ingredients"

      expect(current_path).to eq(chef_ingredients_path(@chef_1))
      expect(page).to have_content("Chef Name: #{@chef_1.name}")
      expect(page).to have_content("Chef's Ingredients: #{@ingredient_2.name} and #{@ingredient_1.name}")
      expect(page).to_not have_content("#{@ingredient_3.name}")
    end
  end

  describe "extension" do
    it 'displays a list of the 3 most popular ingredient names for the given chef' do
      @ingredient_4 = Ingredient.create!(name: "Apples", calories: 10)
      @dish_5 = @chef_1.dishes.create(name: "Dish 5", description: "123")
      @dish_6 = @chef_1.dishes.create(name: "Dish 6", description: "456")

      IngredientDish.create!(ingredient_id: @ingredient_2.id, dish_id: @dish_5.id)
      IngredientDish.create!(ingredient_id: @ingredient_2.id, dish_id: @dish_6.id)
      IngredientDish.create!(ingredient_id: @ingredient_1.id, dish_id: @dish_5.id)
      IngredientDish.create!(ingredient_id: @ingredient_1.id, dish_id: @dish_6.id)
      IngredientDish.create!(ingredient_id: @ingredient_3.id, dish_id: @dish_5.id)
      IngredientDish.create!(ingredient_id: @ingredient_3.id, dish_id: @dish_6.id)
      IngredientDish.create!(ingredient_id: @ingredient_4.id, dish_id: @dish_5.id)

      visit chef_path(@chef_1)
      save_and_open_page

      expect(page).to have_content("3 Most Popular Ingredients")
      expect(page).to have_content(@ingredient_2.name)
      expect(page).to have_content(@ingredient_1.name)
      expect(page).to have_content(@ingredient_3.name)
      expect(page).to_not have_content(@ingredient_4.name)

      expect(@ingredient_2.name).to appear_before(@ingredient_1.name)
      expect(@ingredient_1.name).to appear_before(@ingredient_3.name)
    end
  end
end
