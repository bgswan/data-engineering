class Purchase < ActiveRecord::Base
  
  belongs_to :purchaser
  belongs_to :item
  
  def total
    item.price * quantity
  end
end
