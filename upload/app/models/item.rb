class Item < ActiveRecord::Base
  
  belongs_to :merchant
  has_many :purchases
end
