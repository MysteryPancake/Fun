setInterval(function() {
	var stuff = document.querySelectorAll("*");
	for (var i = 0; i < stuff.length; i++) {
		stuff[i].style.transform = "translate(" + ((Math.random() * 10) - 5) + "px, " + ((Math.random() * 10) - 5) + "px)";
		//stuff[i].style.transform = "rotate(" + ((Math.random() * 6) - 3) + "deg)";
	}
}, 10);
