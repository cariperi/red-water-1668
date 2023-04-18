# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dish.destroy_all
Ingredient.destroy_all
IngredientDish.destroy_all
Chef.destroy_all

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
