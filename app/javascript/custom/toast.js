document.addEventListener("turbo:load", function() {
  $('.toast-close').click(function() {
    let toast = $(this).parents('.toast-container');
  
    toast.fadeOut('slow', function() {
      toast.remove();
    });
  });
})