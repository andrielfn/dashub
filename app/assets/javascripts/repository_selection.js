$(function($) {
  $('.suggested-repo').click(function() {
    var repositoryName  = $(this).text(),
        repositoryInput = $('#repository_full_name');

    repositoryInput.val(repositoryName);
  });
});
