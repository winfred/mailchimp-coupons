MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.CouponView extends Backbone.View
  template: JST["backbone/templates/coupons/coupon"]

  events:
    "click .destroy" : "destroy"
    "click .icon-pencil": "edit"
    "blur .editable-name input": "update"
    "mouseenter .popper": "showPopover"
    "mouseleave .popper": "hidePopover"

  tagName: "tr"

  destroy: (e) ->
    view = this
    $(e.target).confirmable {
      callback: ()->
        view.model.destroy()
        view.remove()
    },'show'

    return false

  showPopover: (e)->
    $(e.target).popover('show')

  hidePopover: (e)->
    $(e.target).popover('hide')

  edit: (e) ->
    @edit_button = $(e.target)
    @name_field =  $(e.target).siblings('.editable-name')
    @name_field.html("<input type='text' value='#{@name_field.text()}' />")
    @edit_button.hide()
    @name_field.children('input').focus()

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