require File.dirname(__FILE__) + '/../spec_helper'

describe ShippingRestriction do
  before(:each) do
    @shipping_restriction = ShippingRestriction.new
  end

  it "should be valid" do
    @shipping_restriction.should be_valid
  end
end
