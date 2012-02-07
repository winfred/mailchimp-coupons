require 'spec_helper'

describe "coupons/show" do
  before(:each) do
    @coupon = assign(:coupon, stub_model(Coupon,
      :user_id => 1,
      :list_id => "List",
      :merge_tag => "Merge Tag"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/List/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Merge Tag/)
  end
end
