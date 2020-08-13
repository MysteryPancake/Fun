function randomSymbol() {
	return Math.round(Math.random()) > 0.5 ? "00" : "FF";
}

setInterval(function() {
	var shit = document.querySelectorAll("th, td");
	for (var i = 0; i < shit.length; i++) {
		shit[i].style.backgroundColor = "#" + randomSymbol() + randomSymbol() + randomSymbol();
	}
}, 10);
