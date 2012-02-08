require 'spec_helper'

describe DatabaseImport do
  
  subject do 
    import_data = Import.new(File.open('spec/fixtures/example_input.tab', 'r'))
    DatabaseImport.new(import_data)
  end
  
  it "creates a purchaser" do
    subject.import
    
    assert Purchaser.exists? :name => 'Amy Pond'
  end
  
  it "does not create a purchaser if they already exist" do
    Purchaser.create(:name => 'Amy Pond')
    
    subject.import
    
    assert_equal 1, Purchaser.where(:name => 'Amy Pond').count
  end
  
  it "creates a merchant" do
    subject.import

    assert Merchant.exists? :name => "Bob's Pizza"
  end
  
  it "does not create a merchant if they already exist" do
    Merchant.create(:name => "Bob's Pizza", :address => "987 Fake St")
    
    subject.import
    
    assert_equal 1, Merchant.where(:name => "Bob's Pizza", :address => "987 Fake St").count
  end
  
  it "creates an item for the merchant" do
    subject.import

    assert Item.exists? :description => "$30 of awesome for $10"
    item_merchant = Merchant.where(:name => "Tom's Awesome Shop").first
    assert_equal "$30 of awesome for $10", item_merchant.items.first.description
  end
  
  it "does not create an item if it already exists" do
    merchant = Merchant.create(:name => "Tom's Awesome Shop", :address => "456 Unreal Rd")
    Item.create(:description => "$30 of awesome for $10", :price => 10.0, :merchant => merchant)
    
    subject.import
    
    assert_equal 1, Item.where(:description => "$30 of awesome for $10", :price => 10.0).count
  end
  
  it "creates a purchase for the purchaser and item" do
    subject.import
    
    purchaser = Purchaser.where(:name => 'Amy Pond').first
    item = Item.where(:description => "$30 of awesome for $10", :price => 10.0).first

    assert Purchase.exists? :purchaser_id => purchaser.id, :item_id => item.id, :quantity => 5
  end
  
  it "does not check for duplicate purchases" do
    purchaser = Purchaser.create(:name => 'Amy Pond')
    item = Item.create(:description => "$30 of awesome for $10", :price => 10.0)
    merchant = Merchant.create(:name => "Tom's Awesome Shop", :address => "456 Unreal Rd")
    merchant.items << item
    Purchase.create(:purchaser => purchaser, :item => item, :quantity => 5)
    
    subject.import
    
    assert_equal 2, Purchase.where(:purchaser_id => purchaser.id, :item_id => item.id, :quantity => 5).count
  end
  
  it "records the total revenue uploaded" do
    subject.import

    assert_equal 95.0, subject.total_revenue_imported
  end
  
  it "records the number of records uploaded" do
    subject.import

    assert_equal 4, subject.total_records_imported
  end
  
  it "rolls back import if there are any errors" do
    Purchaser.stub(:find_or_create_by_name).and_raise(ActiveRecord::ActiveRecordError.new("failed"))
    
    subject.import
    
    assert_equal 0, Purchaser.count
    assert_equal 0, Merchant.count
    assert_equal 0, Item.count
    assert_equal 0, Purchase.count
  end
  
  it "records errors from failed upload" do
    Purchaser.stub(:find_or_create_by_name).and_raise(ActiveRecord::ActiveRecordError.new("failed"))
    
    subject.import
    
    assert_equal "failed", subject.error
  end
  
end
