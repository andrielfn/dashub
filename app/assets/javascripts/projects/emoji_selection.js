Emoji = function(input, suggestionList, initialEmoji, allEmojis) {
  this.input = input;
  this.suggestionList = suggestionList;
  this.allEmojis = allEmojis;

  this.changeInputBackground(initialEmoji);
  this.addEventListeners();
}

Emoji.prototype.addEventListeners = function() {
  this.input.on("change", this.changeEmojiFromInput.bind(this));
  this.suggestionList.on("click", this.clickOnSuggestedEmojis.bind(this));
}

Emoji.prototype.changeEmojiFromInput = function(event) {
  var emoji = $(event.target).val();
  this.changeInputBackground(emoji);
}

Emoji.prototype.clickOnSuggestedEmojis = function(event) {
  event.preventDefault();
  var emoji = $(event.target).attr('alt');
  this.changeInputBackground(emoji);
  this.input.val(emoji);
}

Emoji.prototype.changeInputBackground = function(emoji) {
  this.input.css('background-image', "url(" + this.getEmojiURL(emoji) + ")");
}

Emoji.prototype.getEmojiURL = function(emoji) {
  return this.allEmojis.find("[value='"+ emoji +"']").data("url");
}
