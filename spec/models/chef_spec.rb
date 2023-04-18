require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe "instance methods" do
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

    describe '#get_ingredient_names' do
      it 'returns a formatted string list of unique ingredient names' do
        expect(@chef_1.get_ingredient_names).to eq("Salt and Sugar")
        expect(@chef_2.get_ingredient_names).to eq("Pepper and Sugar")
      end
    end

    describe '#most_popular_3_ingredients' do
      it 'returns a list of the 3 most popular ingredient names for this chef, sorted in order most to least' do
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

        expect(@chef_1.most_popular_3_ingredients).to eq([@ingredient_2.name, @ingredient_1.name, @ingredient_3.name])
      end
    end
  end
end