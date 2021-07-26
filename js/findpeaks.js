// Dodgy O(n) peak finding algorithm written by me
function findPeaks(arr) {
	let last = arr[0];
	let lastBigger = true;
	let peaks = [];
	for (let i = 1; i < arr.length; i++) {
		if (arr[i] <= last && lastBigger) {
			peaks.push(last); // Peak index is i - 1
		}
		lastBigger = arr[i] >= last;
		last = arr[i];
	}
	return peaks;
}

console.log(findPeaks([8, 6, 4, 9, 7, 7, 7, 3, 10, 5])); // Expected output: [8, 9, 7, 7, 10]