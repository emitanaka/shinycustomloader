/* When recalculating starts, show the loader container & hide the output */
$(document).on('shiny:recalculating', function(event) {
    $(".recalculating").siblings(".load-container, .shiny-loader-placeholder").show();
    $(".recalculating").siblings(".load-container").siblings('.shiny-bound-output, .shiny-output-error').css('visibility', 'hidden');
    // if there is a proxy div, hide the previous output
    $(".recalculating").siblings(".shiny-loader-placeholder").siblings('.shiny-bound-output, .shiny-output-error').addClass('shiny-loader-hidden');
});

/* When new value or error comes in, hide loader container (if any) & show the output */
$(document).on('shiny:value shiny:error', function(event) {
  console.log(event.target.id);
    $("#"+event.target.id).siblings(".load-container, .shiny-loader-placeholder").hide();
    $("#"+event.target.id).siblings(".load-container").siblings('.shiny-bound-output').css('visibility', 'visible');
    // if there is a proxy div, show the previous output in case it was hidden
    $("#"+event.target.id).siblings(".shiny-loader-placeholder").siblings('.shiny-bound-output').removeClass('shiny-loader-hidden');
});
