$(document).ready(function () {
  $('[data-function="clone-input"]').click(function () {
    $input = $(this).prev('input');
    $input.clone().insertAfter($input);
  });

  //$()
  //  if (email) {
  //     if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))) {
  //         text = text + "Emailadressen er ugyldigt\n";
  //         error = 1;
  //     }
  //  }

});
// Fill the fields in the form with 'unknown'
function fill_unknown_fields() {
    $('#person_given_name').val('unknown');
    $('#person_family_name').val('unknown');
}