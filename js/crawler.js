"use strict";

const request = require("request");
const cheerio = require("cheerio");

const directories = [];
const files = ["https://source.maxofs2d.net/rigs/3ds_2009/_WARNING_-_these_files_are_deprecated"];
const ignore = ["mailto:ml.maxofs2d@gmail.com", "http://www.evoluted.net", "&sort=asc", "?dir=./", "https://www.youtube.com/channel/UC1umWYFZdqOrKuhR0ALig5A", "https://www.maxofs2d.net"];

function arrayFind(array, word) {
	let value = false;
	for (let i = 0; i < array.length; i++) {
		if (word.indexOf(array[i]) !== -1) {
			value = true;
		}
	}
	return value;
}

function arrayContains(array, url) {
	return array.indexOf(url) !== -1;
}

function isFile(path) {
	return path.split("/").pop().indexOf(".") !== -1;
}

function findFiles(dir) {
	request(dir, function(error, response, body) {
		if (body) {
			const $ = cheerio.load(body);
			$("a").each(function() {
				const url = $(this).attr("href");
				if (!arrayFind(ignore, url)) {
					if (isFile(url)) {
						if (!arrayContains(files, url)) {
							files.push(url);
							console.log(files.length - 1, url);
						}
					} else {
						if (!arrayContains(directories, url)) {
							directories.push(url);
							findFiles("https://source.maxofs2d.net" + url);
						}
					}
				}
			});
		}
	});
}

findFiles("https://source.maxofs2d.net"); // 249 files