var elems = document.querySelectorAll("a,time,h1,p");

setInterval(function() {
	elems[Math.floor(Math.random()*elems.length)].textContent = "Sample Text";
}, 100);
