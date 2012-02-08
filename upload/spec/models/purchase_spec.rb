require 'spec_helper'

describe Purchase do
  
  let(:item) {Item.create(:price => 10.0)}
  let(:purchaser) {Purchaser.create}
  
  it "has a item and purchaser" do
    purchase = Purchase.new(:item => item, :purchaser => purchaser, :quantity => 1)
    
    assert_equal item, purchase.item
    assert_equal purchaser, purchase.purchaser
  end
  
  it "calculates the total of the purchase" do
    purchase = Purchase.new(:item => item, :purchaser => purchaser, :quantity => 2)
    
    assert_equal 20.0, purchase.total
  end
  
end
