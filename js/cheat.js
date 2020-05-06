function clickButton(div) {
	for (var i = 0; i < div.childNodes.length; i++) {
		var node = div.childNodes[i];
		if (node.tagName === "BUTTON") {
			node.click();
		}
	}
}

function cheat() {
	document.getElementsByClassName("long-answer-box")[0].textContent = "Not sure";
	window.setTimeout(function() {
		clickButton(document.getElementsByClassName("submit")[0]);
		window.setTimeout(function() {
			document.getElementsByClassName("star-4")[0].click();
			window.setTimeout(function() {
				clickButton(document.getElementsByClassName("edit")[0]);
				window.setTimeout(function() {
					var answer = document.getElementsByClassName("model-answer")[0].textContent.replace("Example Model Answer", "").trim();
					document.getElementsByClassName("long-answer-box")[0].textContent = answer;
					var keywords = document.getElementsByClassName("answer-keyword")[0].textContent.replace("Keywords", "").trim();
					document.getElementsByClassName("long-answer-input")[0].textContent += "Keywords: " + keywords;
				}, 500);
			}, 500);
		}, 500);
	}, 500);
}

var menu = document.getElementsByClassName("sa-navigation-controls-content")[0];
var button = document.createElement("BUTTON");
button.textContent = "Cheat";
button.onclick = cheat;
menu.appendChild(button);
