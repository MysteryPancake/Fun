"use strict";

window.setInterval(function() {
	var answer = document.getElementsByClassName("field native-font ng-binding")[1].textContent;
	if (!answer) {
		document.getElementById("hint-button").click();
	}
	document.getElementById("answer-text").value = answer;
}, 10);
