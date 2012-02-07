MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.IndexView extends Backbone.View
  template: JST["backbone/templates/coupons/index"]

  initialize: () ->
    @options.coupons.bind('reset', @addAll)

  addAll: () =>
    @options.coupons.each(@addOne)

  addOne: (coupon) =>
    view = new MailchimpCoupons.Views.Coupons.CouponView({model : coupon})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(coupons: @options.coupons.toJSON() ))
    @addAll()

    return this
