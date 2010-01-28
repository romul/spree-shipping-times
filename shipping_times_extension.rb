# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ShippingTimesExtension < Spree::Extension
  version "1.0"
  description "Shipping times"
  url "http://yourwebsite.com/shipping_times"
  
  def activate

    Taxon.class_eval do
      belongs_to :shipment_center
    end      

    Product.class_eval do
      belongs_to :shipment_center
      has_many :shipping_restrictions
      
      def ship_center
        center = self.shipment_center
        if center.nil?
          shipment_center_taxon = self.taxons.detect{ |t| t.shipment_center_id }
          center = shipment_center_taxon.shipment_center if shipment_center_taxon
        end
        center
      end
      
      def all_shipping_restrictions
        (self.product_groups.map{|pg| pg.shipping_restrictions}.flatten.compact + 
          self.shipping_restrictions).uniq
      end
    end
    
    ProductGroup.class_eval do
      has_many :shipping_restrictions
    end
    
    Zone.class_eval do
      has_many :shipping_restrictions
    end
    
    Admin::ProductsController.class_eval do
      before_filter :load_shipment_centers, :only => :edit
      
      private
      def load_shipment_centers
        @shipment_centers = ShipmentCenter.all
      end
    end  

  end
end
