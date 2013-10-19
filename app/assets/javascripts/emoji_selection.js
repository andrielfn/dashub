$(function($) {
  $(document).on('click', 'span[data-emoji]', function(event) {
    var emoji = ':' + $(this).data('emoji') + ':',
        approval_emoji = $('#project_approval_emoji');

    approval_emoji.val(emoji);
  });
});
