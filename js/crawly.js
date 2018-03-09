"use strict";

const request = require("request");
const cheerio = require("cheerio");

function isFile(path) {
	return path.split("/").pop().indexOf(".") !== -1;
}

function findFiles(dir) {
	request(dir, function(error, response, body) {
		if (body) {
			const $ = cheerio.load(body);
			$("a").each(function() {
				const url = $(this).attr("href");
				if (url && url !== "../") {
					if (isFile(url)) {
						console.log(dir + url);
					} else {
						findFiles(dir + url);
					}
				}
			});
		}
	});
}

findFiles("http://example.com/");
