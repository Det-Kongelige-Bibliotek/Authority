(function($) {
    $.fn.extend({
        authority_typeahead: function(options) {
            options = $.extend( {}, $.authority_typeahead.defaults, options );

            this.each(function() {
                new $.authority_typeahead(this,options);
            });
            return this;
        }
    });

    $.authority_typeahead = function( ctl, options ) {

        if (options.remove) {
          typeahead_field = $(ctl).next("#"+ctl.id + "_typeahead");
          typeahead_field.autocomplete("destroy");
          typeahead_field.remove();
            $(ctl).show();
        } else {
            typeahead_field = $(ctl).clone().attr("id", ctl.id + "_typeahead").removeAttr("name").removeAttr("data-function").removeAttr("data-model");
            typeahead_field.insertAfter(ctl);
            typeahead_field.autocomplete({
                source: '/authority/finder/search/' + options.model + '/',
                minLength: 2,
                select: function( event, ui ) {
                    if (ui.item) {
                        $("#" + ctl.id).val(ui.item.id);
                    } else {
                        alert("Could not find the person " + this.val + ". Try creating a new person object");
                    }
                }
            });

            if ($(ctl).val() != "") {
                $.ajax({
                    type: 'GET',
                    async: false,
                    url: '/authority/finder/getobj/' + encodeURIComponent($(ctl).val()),
                    dataType: 'json',
                    success: function (data) {
                        typeahead_field.val(data.value);
                    }
                });
            }

            // hide the original input field
            $(ctl).hide()
        }
    };

    $.authority_typeahead.defaults = {
        remove: false,
        model: "all"
    };

})(jQuery);