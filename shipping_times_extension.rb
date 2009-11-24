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
      
      def ship_center
        center = self.shipment_center
        if center.nil?
          shipment_center_taxon = self.taxons.detect{ |t| t.shipment_center_id }
          center = shipment_center_taxon.shipment_center if shipment_center_taxon
        end
        center
      end
    end

    # Add a link to the shipment centers administration page on the configuration page
    Admin::ConfigurationsController.class_eval do
      before_filter :add_shipment_center_links, :only => :index

      def add_shipment_center_links
        @extension_links << {:link => admin_shipment_centers_path, :link_text => t(:shipment_centers), :description => t(:manage_shipment_centers)}
      end

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
