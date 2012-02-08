module ImportsHelper
  
  def import_results(database_import)
    return "" if database_import.nil?
    
    if database_import.error.blank?
      "Import successful: #{number_to_currency(database_import.total_revenue_imported)} total revenue imported from #{database_import.total_records_imported} records"
    else
      "Import failed: #{database_import.error}"
    end
  end
  
end