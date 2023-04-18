require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}

    it {should have_many :ingredient_dishes}
    it {should have_many(:ingredients).through(:ingredient_dishes)}
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

    describe "#get_calorie_count" do
      it 'returns the calorie count for a specific dish' do
        expect(@dish_1.get_calorie_count).to eq(30)
        expect(@dish_2.get_calorie_count).to eq(20)
      end
    end
  end
end