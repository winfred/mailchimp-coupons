MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.CouponView extends Backbone.View
  template: JST["backbone/templates/coupons/coupon"]

  events:
    "click .destroy" : "destroy"
    "click .icon-pencil": "edit"
    "blur .editable-name input": "update"
    "mouseenter .popper": "showPopover"
    "mouseleave .popper": "hidePopover"
    "click .send-to-consumed": "sendToConsumed"
    "click .send-to-unconsumed": "sendToUnconsumed"
    
    

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

  sendToConsumed: (e) ->
    button = e.target
    $(button).removeClass('send-to-consumed').addClass('disabled').text('loading')
    $.post("/coupons/#{@model.id}/send_to_consumed", (data,text,xhr) -> 
      MailchimpCoupons.Views.showSuccess("<strong>Success!</strong> Your campaign has been created and can be edited <a href='#{data.url}' target='_blank'>here<a/>.",{html: true})
      $(button).removeClass('disabled').addClass('send-to-consumed').text('Send to Consumers')
    )
    
  sendToUnconsumed: (e) ->
    button = e.target
    $(button).removeClass('send-to-unconsumed').addClass('disabled').text('loading')
    $.post("/coupons/#{@model.id}/send_to_unconsumed", (data,text,xhr) -> 
      MailchimpCoupons.Views.showSuccess("<strong>Success!</strong> Your campaign has been created and can be edited <a href='#{data.url}' target='_blank'>here<a/>.",{html: true})
      $(button).addClass('send-to-unconsumed').removeClass('disabled').text('Send to Non-consumers')
    )