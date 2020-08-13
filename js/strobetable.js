function randomSymbol() {
	return Math.round(Math.random()) > 0.5 ? "00" : "FF";
}

setInterval(function() {
	var stuff = document.querySelectorAll("th, td");
	for (var i = 0; i < stuff.length; i++) {
		stuff[i].style.backgroundColor = "#" + randomSymbol() + randomSymbol() + randomSymbol();
	}
}, 10);
