class ImportsController < ApplicationController

  # POST /imports
  def create
    import_data = Import.new(params[:data].try(:tempfile))
    @database_import = DatabaseImport.new(import_data)

    @database_import.import
    
    render :new
  end

end
