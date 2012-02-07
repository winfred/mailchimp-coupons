#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.MailchimpCoupons =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {
    showSuccess: (message, opts) ->
      MailchimpCoupons.Views.createNotice()
      if opts?.html
        $('.alert p:first').html(message).parent('div').attr("class","alert fade in alert-success").show()
      else
        $('.alert p:first').text(message).parent('div').attr("class","alert fade in alert-success").show()
    showWarning: (message, opts) ->
      MailchimpCoupons.Views.createNotice()
      if (opts?.html)
        $('.alert p:first').html(message).parent('div').show()
      else
        $('.alert p:first').text(message).parent('div').show()
    showError: (message, opts) ->
      MailchimpCoupons.Views.createNotice()
      if opts?.html
        $('.alert p:first').html(message).parent('div').addClass("alert-error").show()
      else
        $('.alert p:first').text(message).parent('div').addClass("alert-error").show()
    createNotice: ->
      $('#coupons').prepend('<div class="alert fade in" style="display: none"><a class="close" data-dismiss="alert" href="#">x</a><p></p></div>')
      $(".alert").alert()
  }

$(document).ready ->
  $.ajaxSetup({
    headers: 
      'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
    ,dataType: 'json',
    error: ->
      MailchimpCoupons.Views.showError("Uh oh, it looks like there was a connection error.")

  })
