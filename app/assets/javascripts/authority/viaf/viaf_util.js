// Function for importing data in the "New Person" form from VIAF
function viafImport(type) {
    // Create the link of the RDF record
    var link = $('#thing_same_as_uri').val() + '/rdf.xml';
    $.ajax({
        type: "GET",
        // Call the viaf function from the people_controller or organizations_controller that returns a JSON
        url: "/authority/"+type+"/viaf",
        dataType: "json",
        data: {
            // The RDF record link is passed as parameter to viaf function
            url: link
        },
        success: function(response) {
            console.log(link);
            console.log(response);

            if (type == 'people'){
                if(response.first_name){$('#person_given_name').val(response.first_name);}
                if(response.family_name){$('#person_family_name').val(response.family_name);}
                if(response.alternate_name){$('#person_alternate_names').val(response.alternate_name);}
            }
            else if (type == 'organizations'){
                if(response.org_name){$('#organization__name').val(response.org_name);}
                if(response.alternate_name){$('#organization_alternate_names').val(response.alternate_name);}
            }
            else{
                // If the json file is empty, an alert message appears.
                alert("No data to import.");
            }

            var old_field = $('#thing_same_as_uri');
            var new_field = old_field.clone(true);
            new_field.val(response.isni_uri);
            new_field.insertAfter(old_field);
        }
        ,
        error: function (request, status, error) {
            alert('No data to import.');
        }
    });
}
// Function for the VIAF autocomplete
function viaf_autocomplete(){

    var viafagents2 = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: 'http://viaf.org/viaf/AutoSuggest?query=%QUERY&callback=?',
            wildcard: '%QUERY',
            ajax: {
                jsonp: 'callback',
                type: 'GET',
                dataType: 'jsonp'
            },
            filter: function(data) {
                return data.result;
            }
        }
    });

    $("#myViafId").typeahead({
            minLength: 1,
            highlight: true },
         {
            name: 'ViafAgents',
            source: viafagents2,
            limit: 9,
            displayKey: 'term',
            templates: {
                header: '<h3 class="agent-source">VIAF</h3>',
                empty: '<div class="empty-message">Ingen viaf agenter fundet</div>'
            }
        }).bind('typeahead:select', function(event, suggestion) {
            $('#thing_same_as_uri').val("http://viaf.org/viaf/" + suggestion.viafid)
        });


};

$('document').ready(function(){
    viaf_autocomplete();
});
