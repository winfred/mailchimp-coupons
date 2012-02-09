MailchimpCoupons.Views.Coupons ||= {}

class MailchimpCoupons.Views.Coupons.NewView extends Backbone.View
  template: JST["backbone/templates/coupons/new"]

  events:
    "submit #new-coupon": "save"
    "mouseenter .popper": "showPopover"
    "mouseleave .popper": "hidePopover"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    list_id = $('select[name=list_id]').val()
    @model.set {
      list_id: list_id
      list_name: $('select[name=list_id] option[value='+list_id+']').text()
    }
    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (coupon) =>
        @model = coupon
        window.location.hash = "/index"

      error: (coupon, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
  
  showPopover: (e)->
    $(e.target).popover('show')

  hidePopover: (e)->
    $(e.target).popover('hide')
