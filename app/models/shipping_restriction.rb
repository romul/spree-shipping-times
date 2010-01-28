class ShippingRestriction < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_group
  belongs_to :zone
  validates_presence_of :zone
  validates_presence_of :product, :if => Proc.new { |sr| sr.product_group.nil? }
  validates_presence_of :product_group, :if => Proc.new { |sr| sr.product.nil? }  

  def covers?(product)
    product == self.product || product.product_groups.include?(self.product_group)
  end
  
  def covers_zone?(zone)
    zone == self.zone
  end
  
  def product_sku
    self.product.try(:sku)
  end
  
  def product_sku=(sku)
    self.product = sku.blank? ? nil : Variant.sku_equals(sku).first.try(:product) 
  end
  
end
