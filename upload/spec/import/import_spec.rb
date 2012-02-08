require 'spec_helper'
require 'data_helper'

describe Import do
  
  it "converts input data to record" do
    import = Import.new(DataHelper.sample_input)
    records = []
    
    import.each_record do |r|
      records << r
    end
    
    assert_equal 1, records.size
    assert_equal "Snake Plissken", records[0].purchaser_name
    assert_equal "$10 off $20 of food", records[0].item_description
    assert_equal "10.0", records[0].item_price
    assert_equal "2", records[0].purchase_count
    assert_equal "987 Fake St", records[0].merchant_address
    assert_equal "Bob's Pizza", records[0].merchant_name
  end
  
  it "does not yield any records if input data is nil" do
    import = Import.new(nil)
    records = []
    
    import.each_record do |r|
      records << r
    end
    
    assert_equal 0, records.size
  end
  
end
