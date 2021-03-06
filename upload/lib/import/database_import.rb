class DatabaseImport

  attr_reader :total_revenue_imported, :total_records_imported, :error
   
  def initialize(import_data) 
    @import_data = import_data
    @total_revenue_imported = 0
    @total_records_imported = 0
    @error = ""
  end
   
  def import
    begin
      ActiveRecord::Base.transaction do
        @import_data.each_record do |r|
          purchaser = Purchaser.find_or_create_by_name(r.purchaser_name)
          merchant = Merchant.find_or_create_by_name_and_address(r.merchant_name, r.merchant_address)
          item = Item.find_or_create_by_description_and_price_and_merchant_id(r.item_description, r.item_price, merchant.id)
          purchase = Purchase.create(:item => item, :purchaser => purchaser, :quantity => r.purchase_count)
          @total_revenue_imported += purchase.total
          @total_records_imported += 1
        end
      end
    rescue StandardError => e
      @error = e.to_s
    end
  end

end