$(function($) {
  $('.suggested-repo').click(function() {
    var repositoryName  = $(this).text(),
        repositoryInput = $('#repository_fullname');

    repositoryInput.val(repositoryName);
  });
});
