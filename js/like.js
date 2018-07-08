var hearts = document.getElementsByClassName("creator-heart-big-unhearted");
for (var i = 0; i < hearts.length; i++) {
	hearts[i].parentNode.parentNode.click();
}
var likes = document.getElementsByClassName("sprite_like default-state");
for (var j = 0; j < likes.length; j++) {
	if (likes[j].parentNode.parentNode.className !== "mod-button on") {
		likes[j].click();
	}
}
