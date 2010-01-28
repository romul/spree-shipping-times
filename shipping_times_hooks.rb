class ShippingTimesHooks < Spree::ThemeSupport::HookListener

  insert_after :product_description, "products/shipping_restrictions"

end
