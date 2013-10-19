$(function($) {
  $(document).on('click', 'span[data-emoji]', function(event) {
    var emoji = ':' + $(this).data('emoji') + ':'
      , $approval_rules = $('#project_approval_rule')
      , old_approval_rules = $approval_rules.val();

    $approval_rules.val(old_approval_rules.trim() + ' ' + emoji);
  });
});
