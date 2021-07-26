// Dodgy O(n) peak finding algorithm written by me
function findPeaks(arr) {
	let last = arr[0];
	let lastBigger = true;
	let peaks = [];
	for (let i = 1; i < arr.length; i++) {
		if (arr[i] <= last && lastBigger) {
			peaks.push({ index: i - 1, value: last });
		}
		lastBigger = arr[i] >= last;
		last = arr[i];
	}
	return peaks;
}

console.log(findPeaks([7, 5, 4, 2, 5, 5, 2]));