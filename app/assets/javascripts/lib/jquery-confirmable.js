(function($) { 

    /* Public Methods */
    $.fn.confirmable = function(options, command) {
        //Expose public API
        if (typeof options == "string") {
            if (typeof $.fn.confirmable[options] == 'function') $.fn.confirmable[options]($(this));
        }
        else {
            $('.confirmable-cancellation').click($.fn.confirmable.hide);
            storeDefaultContent();
            this.each(function() {
                bindActionData($(this), options);
            });
            if(command && typeof $.fn.confirmable[command] == 'function') $.fn.confirmable[command]($(this));
        }
    };
    $.confirmableDefaults = function(options) {
        $.fn.confirmable.defaults = options;
    }; 
    
    /* Public-Private Methods */
    $.fn.confirmable.show = function(button) {
        updateModal($(button).data('confirmable')).show();
    };

    $.fn.confirmable.confirm = function() {
        var o = $('.confirmable-modal').data('confirmable');
        if(o.object && o.action && typeof o.object[o.action] == 'function')o.object[o.action]();
        if(typeof o.callback == 'function')o.callback();
        $.fn.confirmable.hide();
        return false;
    };

    $.fn.confirmable.hide = function() {
        $('.confirmable-modal').data('confirmable').hide();
    };

    /* Private Methods */
    var storeDefaultContent = function() {
            $('.confirmable-header').data('confirmable', $('.confirmable-header').html());
            $('.confirmable-body').data('confirmable', $('.confirmable-body').html());
            $('.confirmable-confirmation').data('confirmable', $('.confirmable-confirmation').html());
            $('.confirmable-cancellation').data('confirmable', $('.confirmable-cancellation').html());
        };

    var bindActionData = function(button, options) {
            var o = $.extend({}, $.fn.confirmable.defaults, button.data(), options);
            button.data('confirmable', o);
            button.click(function() {
                $.fn.confirmable.show(button);
                return false;
            });
        };

    var updateModal = function(o) {
            $('.confirmable-modal').data('confirmable', o);
            $('.confirmable-confirmation').unbind('click');
            $('.confirmable-confirmation').click($.fn.confirmable.confirm);

            if (o.header) $('.confirmable-header').html(o.header);
            else $('.confirmable-header').html($('.confirmable-header').data('confirmable'));

            if (o.body) $('.confirmable-body').html(o.body);
            else $('.confirmable-body').html($('.confirmable-body').data('confirmable'));

            if (o.confirmation) $('.confirmable-confirmation').html(o.confirmation);
            else $('.confirmable-confirmation').html($('.confirmable-confirmation').data('confirmable'));

            if (o.cancellation) $('.confirmable-cancellation').html(o.cancellation);
            else $('.confirmable-cancellation').html($('.confirmable-cancellation').data('confirmable'));
            return o;
        }; 
})(jQuery);