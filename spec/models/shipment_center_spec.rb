require File.dirname(__FILE__) + '/../spec_helper'

describe ShipmentCenter do
  before(:each) do
    @shipment_center = ShipmentCenter.new
  end

  it "should be valid" do
    @shipment_center.should be_valid
  end
end
