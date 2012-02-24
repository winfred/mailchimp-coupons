class MailchimpCoupons.Routers.CouponsRouter extends Backbone.Router
  initialize: (options) ->
    @coupons = new MailchimpCoupons.Collections.CouponsCollection()
    @coupons.reset options.coupons
    console.log @coupons

  routes:
    "/new"      : "newCoupon"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id/consume" : "consume"
    "/:id"      : "show"
    ".*"        : "index"

  newCoupon: ->
    @view = new MailchimpCoupons.Views.Coupons.NewView(collection: @coupons)
    $("#coupons").html(@view.render().el)

  index: ->
    $('.popover').remove()
    @view = new MailchimpCoupons.Views.Coupons.IndexView(coupons: @coupons)
    $("#coupons").html(@view.render().el)

  consume: (id) ->
    coupon = @coupons.get(id)
    $('.popover').remove()
    @view = new MailchimpCoupons.Views.Coupons.ConsumeView(model: coupon)
    $("#coupons").html(@view.render().el)
