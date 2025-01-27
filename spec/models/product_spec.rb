require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'Shrubery')
    end

    it 'saves successfully when all fields are entered' do
      product = Product.new(
        name: 'Shrub',
        price_cents: 12345,
        quantity: 5,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'fails to save when a name is not provided' do
      product = Product.new(
        name: nil,
        price_cents: 12345,
        quantity: 5,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails to save when a price is not provided' do
      product = Product.new(
        name: 'Shrub',
        price_cents: nil,
        quantity: 5,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'fails to save when a quantity is not provided' do
      product = Product.new(
        name: 'Shrub',
        price_cents: 12345,
        quantity: nil,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'fails to save when a category is not provided' do
      product = Product.new(
        name: 'Shrub',
        price_cents: 12345,
        quantity: 5,
        category: nil
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
