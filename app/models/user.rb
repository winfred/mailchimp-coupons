class User < ActiveRecord::Base
  has_many :coupons

  def next_coupon_num
    new_count = coupons_count + 1
    update_attribute(:coupons_count, new_count)
    new_count
  end

  def api
    @api ||= Mailchimp::API.new(apikey)
  end
end
