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
          typeahead_field = $(ctl).next(".twitter-typeahead").find("#"+ctl.id + "_typeahead");
          typeahead_field.typeahead("destroy");
          typeahead_field.remove();
            $(ctl).show();
        } else {
            typeahead_field = $(ctl).clone().attr("id", ctl.id + "_typeahead").removeAttr("name");

            typeahead_field.insertAfter(ctl);

            var localagents = new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.whitespace,
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                limit: 10,
                remote: {
                    url: '/authority/finder/search/' + options.model + '/%QUERY',
                    wildcard: '%QUERY'
                }
            });

            typeahead_field.typeahead({
                    minLength: 1,
                    highlight: true
                },
                {
                    name: 'Agents',
                    source: localagents,
                    displayKey: 'val',
                    templates: {
                        header: '<h3 class="agent-source">Valhal</h3>',
                        empty: '<div class="empty-message">Ingen agenter fundet. Opret evt. en ny</div>'
                    }
                }).bind('typeahead:select', function (event, suggestion) {
                    $("#" + ctl.id).val(suggestion.id);
                });

            // update the typeahead field

            if ($(ctl).val() != "") {
                $.ajax({
                    type: 'GET',
                    async: false,
                    url: '/authority/finder/getobj/' + encodeURIComponent($(ctl).val()),
                    dataType: 'json',
                    success: function (data) {
                        typeahead_field.val(data.val);
                    }
                });
            }

            // hide input field
            $(ctl).hide()
        }
    };

    $.authority_typeahead.defaults = {
        remove: false,
        model: "all"
    };

})(jQuery);