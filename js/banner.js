var header = document.getElementById("c4-header") || document.getElementById("c4-header-bg-container");
if (header) {
	var style = window.getComputedStyle(header, false);
	var image = style.getPropertyValue("--yt-channel-banner") || style.backgroundImage;
	var url = image.slice(4, -1).replace(/["\\]/g, "");
	var fullSize = url.replace("-fcrop64=1,00005a57ffffa5a8-nd-c0xffffffff-rj-k-no", "");
	var fullWidth = fullSize.replace("w2120", "w2560");
	window.open(fullWidth);
} else {
	console.error("Couldn't find a banner!");
}
