require 'spec_helper'

describe ImportsHelper do
  
  describe "#import_results" do
    
    it "returns nothing if database_import is nil" do
      assert_equal "", helper.import_results(nil)
    end
    
    it "formats import results" do
      database_import = stub(:database_import, :total_records_imported => 10, :total_revenue_imported => 50.0)
      
      assert_equal "Import successful: $50.00 total revenue imported from 10 records", helper.import_results(database_import)
    end
  end
end
