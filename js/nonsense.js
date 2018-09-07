"use strict";

const request = require("request-promise");

async function getNonsense(word) {
	const req = await request("http://suggestqueries.google.com/complete/search?client=chrome&q=" + word);
	return JSON.parse(req)[1];
}

async function nonsense(word, depth, max) {
	const result = {};
	if (depth > max) return result;
	const mess = await getNonsense(word);
	for (let i = 0; i < mess.length; i++) {
		result[mess[i]] = await nonsense(mess[i], depth + 1, max);
	}
	return result;
}

nonsense("jeff", 0, 1).then(console.log);