"use strict";

var images = document.getElementsByTagName("img");
for (var i = 0; i < images.length; i++) {
	var parent = images[i].parentElement;
	parent.innerHTML = "<iframe width=\"" + parent.offsetWidth + "\" height=\"" + parent.offsetHeight + "\" src=\"https://www.youtube.com/embed/kJQP7kiw5Fk?autoplay=1&controls=0&loop=1&modestbranding=1&rel=0&showinfo=0\"></iframe>";
}
