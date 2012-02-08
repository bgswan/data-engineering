require 'spec_helper'

describe Merchant do
  
  it "has items" do
    merchant = Merchant.create
    merchant.items << Item.new
    
    assert_equal 1, merchant.items.size
  end
end
