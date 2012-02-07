MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.EditView extends Backbone.View
  template : JST["backbone/templates/coupons/edit"]

  events :
    "submit #edit-coupon" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (coupon) =>
        @model = coupon
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
