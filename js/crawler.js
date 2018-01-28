const request = require("request");
const cheerio = require("cheerio");

let directories = [];
let files = ["http://source.maxofs2d.net/rigs/3ds_2009/_WARNING_-_these_files_are_deprecated"];
const ignore = ["mailto:ml.maxofs2d@gmail.com", "http://www.evoluted.net", "&sort=asc", "?dir=./"];

function arrayFind(array, word) {
	let value = false;
	array.forEach(function(str) {
		if (word.indexOf(str) !== -1) {
			value = true;
		}
	});
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
		const $ = cheerio.load(body);
		$("a").each(function() {
			const url = $(this).attr("href");
			if (!arrayFind(ignore, url)) {
				if (isFile(url)) {
					if (!arrayContains(files, url)) {
						files.push(url);
						console.log(files.length, url);
					}
				} else {
					if (!arrayContains(directories, url)) {
						directories.push(url);
						findFiles("http://source.maxofs2d.net" + url);
					}
				}
			}
		});
	});
}

findFiles("http://source.maxofs2d.net"); // 249 files
