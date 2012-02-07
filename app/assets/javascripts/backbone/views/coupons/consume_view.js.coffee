MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.ConsumeView extends Backbone.View
  template: JST["backbone/templates/coupons/consume"]

  events:
    "submit form": "consume"
    "click #subscribe": "subscribe"

  initialize: () ->

  render: =>
    $(@el).html(@template(@model.toJSON()))
    return this

  consume: (e)->
    e.stopPropagation()
    email= $('form#consume input').val()
    $('form#consume input').val(' ')
    view = this
    $.post "/coupons/#{@model.id}/consume/", {email:email},
      (data,text,xhr) ->
        console.log data
        switch data.response
          when "NotSubscribed" then view.renderNotSubscribed(email)
          when "Consumed" then view.renderConsumed(email)
          when "AlreadyConsumed" then view.renderFailure(email)

  subscribe: (email) ->
    $.post "/coupons/#{@model.id}/subscribe/",{email:email,list_id: @model.attributes.list_id},
      (data,text,xhr) ->
        MailchimpCoupons.Views.showSuccess("#{email} has been subscribed!")

  renderConsumed: (email) ->
     MailchimpCoupons.Views.showSuccess("Coupon consumed for <strong>#{email}</strong>.",{html: true})

  renderFailure: (email) ->
    MailchimpCoupons.Views.showError("Coupon already used for <strong>#{email}</strong>.",{html:true})

  renderNotSubscribed: (email) ->
    MailchimpCoupons.Views.showWarning("<strong>#{email}</strong> has not yet subscribed.<br /><br /> <button id='subscribe' class='btn btn-warning' >Do they want to?</button>",{html: true})
    $('#subscribe:first').data({view:this,email: email})
    $("#subscribe:first").click -> $(this).data('view').subscribe($(this).data('email'))
 
