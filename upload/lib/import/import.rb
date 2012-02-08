class Import
  
  DELIMITER = "\t"
  
  def initialize(input_data)
    @input_data = input_data.try(:readlines) || []
  end
  
  def each_record(&block)
    return if @input_data.empty?
    
    headers = @input_data.delete_at(0).strip.split(DELIMITER).map{|header| header.to_s.downcase.gsub(' ', '_').to_sym}
    record = Struct.new(*headers)
    @input_data.each do |line|
      block.call record.new(*line.strip.split(DELIMITER))
    end
  end
end