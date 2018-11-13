(() => {
  $(document).ready(() => {
    $('form[data-js]').submit((e) => {
      const message = $(e.target).find('[data-confirmation]');

      if (message && !confirm(message.val())) {
        e.preventDefault();
      }
    });
  })
})(jQuery);
