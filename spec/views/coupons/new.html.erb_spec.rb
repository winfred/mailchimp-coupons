require 'spec_helper'

describe "coupons/new" do
  before(:each) do
    assign(:coupon, stub_model(Coupon,
      :user_id => 1,
      :list_id => "MyString",
      :merge_tag => "MyString"
    ).as_new_record)
  end

  it "renders new coupon form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => coupons_path, :method => "post" do
      assert_select "input#coupon_user_id", :name => "coupon[user_id]"
      assert_select "input#coupon_list_id", :name => "coupon[list_id]"
      assert_select "input#coupon_merge_tag", :name => "coupon[merge_tag]"
    end
  end
end
