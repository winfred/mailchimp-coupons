require 'spec_helper'

describe "coupons/index" do
  before(:each) do
    assign(:coupons, [
      stub_model(Coupon,
        :user_id => 1,
        :list_id => "List",
        :merge_tag => "Merge Tag"
      ),
      stub_model(Coupon,
        :user_id => 1,
        :list_id => "List",
        :merge_tag => "Merge Tag"
      )
    ])
  end

  it "renders a list of coupons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "List".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Merge Tag".to_s, :count => 2
  end
end
