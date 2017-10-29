$(document).ready(function() {
    $('input[type=radio]').change(function() {
        var submit_button = $('#submit-question');

        if (submit_button.is(":disabled")){
            submit_button.attr('disabled', false);
        }
    });
});
