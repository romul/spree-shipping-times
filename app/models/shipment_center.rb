class ShipmentCenter < ActiveRecord::Base
  has_many :taxons
  has_many :products
end
