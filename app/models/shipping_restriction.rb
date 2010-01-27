class ShippingRestriction < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_group
  belongs_to :zone

  def covers?(product)
    product == self.product || product.product_groups.include?(self.product_group)
  end
  
  def product_sku
    self.product.try(:sku)
  end
  
  def product_sku=(sku)
    self.product = sku.blank? ? nil : Variant.sku_equals(sku).first.try(:product) 
  end
  
end
