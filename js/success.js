var bars = document.getElementsByClassName("progress-bar progress-bar-success");
for (var i = 0; i < bars.length; i++) {
	bars[i].style.width = "100%";
	bars[i].innerHTML = 100;
}
