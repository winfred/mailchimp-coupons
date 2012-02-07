MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.CouponView extends Backbone.View
  template: JST["backbone/templates/coupons/coupon"]

  events:
    "click .destroy" : "destroy"
    "click .icon-pencil": "edit"
    "blur .editable-name input": "update"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  edit: (e) ->
    @edit_button = $(e.target)
    @name_field =  $(e.target).siblings('.editable-name')
    @name_field.html("<input type='text' value='#{@name_field.text()}' />")
    @edit_button.hide()

  update: (e) ->
    name = $(e.target).val()
    @name_field.text name
    @edit_button.show()
    if @model.attributes.name isnt name
      @model.save({name: name},
        success : (coupon) =>
          @model = coupon
      )



  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
