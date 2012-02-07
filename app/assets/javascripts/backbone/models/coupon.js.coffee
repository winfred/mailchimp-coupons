class MailchimpCoupons.Models.Coupon extends Backbone.Model
  paramRoot: 'coupon'
  

  defaults:
    name: null
    list_id: null
    parameter_name: null
    list_name: null

class MailchimpCoupons.Collections.CouponsCollection extends Backbone.Collection
  model: MailchimpCoupons.Models.Coupon
  url: '/coupons'
