class ShippingTimesHooks < Spree::ThemeSupport::HookListener

  insert_after :product_description, "products/shipping_restrictions"
  insert_after :admin_configurations_menu, "admin/shipment_centers/admin_link"
  insert_after :admin_configurations_menu, "admin/shipping_restrictions/admin_link"

end
