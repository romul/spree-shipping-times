class CreateShipmentCenters < ActiveRecord::Migration
  def self.up
    create_table :shipment_centers do |t|
      t.string :name
      t.string :in_stock_shipping_time
      t.string :out_stock_shipping_time
      
      t.timestamps
    end
    
    add_column :taxons, :shipment_center_id, :integer
    add_column :products, :shipment_center_id, :integer   
  end

  def self.down
    remove_column :taxons, :shipment_center_id
    remove_column :products, :shipment_center_id 
    drop_table :shipment_centers
  end
end
