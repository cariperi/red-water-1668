require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :calories}
  end

  describe "relationships" do
    it {should have_many :ingredient_dishes}
    it {should have_many(:dishes).through(:ingredient_dishes)}
  end
end