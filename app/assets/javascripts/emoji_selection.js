$(function($) {
  var emojiIcon = $('#chosen-emoji');

  function emojiUrlFor(emoji) {
    return $("#all-emojis [value='" + emoji + "']").data('url');
  }

  function updateEmojiIconFor(emoji) {
    var emojiUrl = emojiUrlFor(emoji);

    if (emojiUrl) {
      emojiIcon.attr('src', emojiUrl);
    }
  }

  $(document).on('click', 'span[data-emoji]', function(event) {
    var emoji = $(this).data('emoji'),
        approval_emoji = $('#project_approval_emoji');

    approval_emoji.val(emoji);
    updateEmojiIconFor(emoji);
  });

  $('#project_approval_emoji').keydown(function() {
    updateEmojiIconFor($(this).val());
  });
});
