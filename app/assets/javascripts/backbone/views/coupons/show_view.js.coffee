MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.ShowView extends Backbone.View
  template: JST["backbone/templates/coupons/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
