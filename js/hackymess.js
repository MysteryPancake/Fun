"use strict";

function meme(thing) {
	var chars = [];
	for (var i = 0; i < thing.length; i++) {
		if (chars[chars.length - 1] && chars[chars.length - 1].char === thing.charAt(i)) {
			chars[chars.length - 1].count++;
		} else {
			chars.push({ char: thing.charAt(i), count: 1 });
		}
	}
	var final = "";
	for (var j = 0; j < chars.length; j++) {
		final += chars[j].count + chars[j].char;
	}
	return final;
}

alert(meme(prompt("Type some crap here")));