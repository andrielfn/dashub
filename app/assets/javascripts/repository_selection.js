$(function($) {
  var currentRepo;

  $('.suggested-repo').click(function() {
    var repositoryName  = $(this).text(),
        repositoryInput = $('#repository_full_name');

    repositoryInput.val(repositoryName);
    $(currentRepo).removeClass('selected');
    $(this).addClass('selected');
    currentRepo = this;
  });
});
