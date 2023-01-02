require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "initials test" do
      @category = Category.new(name: "testCategory")
      @product = Product.new(name: "testProduct", price: "500", quantity: "5", category: @category)
      @product.save
      expect(@product.id).to be_present
    end

    it "validates name" do
      @category = Category.new(name: "testCategory")
      @product = Product.new(name: nil, price: "500", quantity: "5", category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    
    it "validates price" do
      @category = Category.new(name: "testCategory")
      @product = Product.new(name: "testProduct", quantity: "5", category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "validates quantity" do
      @category = Category.new(name: "testCategory")
      @product = Product.new(name: "testProduct", price: "500", quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates category" do
      @category = Category.new(name: "testCategory")
      @product = Product.new(name: "testProduct", price: "500", quantity: "5", category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end