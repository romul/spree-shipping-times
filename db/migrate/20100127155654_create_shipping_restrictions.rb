class CreateShippingRestrictions < ActiveRecord::Migration
  def self.up
    create_table :shipping_restrictions do |t|
      t.references :product
      t.references :product_group
      t.references :zone
    end
  end

  def self.down
    drop_table :shipping_restrictions
  end
end
