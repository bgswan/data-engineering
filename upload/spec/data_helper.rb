class DataHelper
  
  def self.header
    "purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name"
  end
  
  def self.input_line
    "Snake Plissken\t$10 off $20 of food\t10.0\t2\t987 Fake St\tBob's Pizza"
  end
  
  def self.sample_input
    StringIO.new("#{header}\n#{input_line}")
  end
end

