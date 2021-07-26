// My O(n) peak finding algorithm
function findPeaks(arr) {
	let prev = arr[0];
	let prevBigger = true;
	let peaks = [];
	for (let i = 1; i < arr.length; i++) {
		if (arr[i] <= prev && prevBigger) {
			peaks.push(prev); // Peak index is i - 1
		}
		prevBigger = arr[i] >= prev;
		prev = arr[i];
	}
	return peaks;
}

console.log(findPeaks([8, 6, 4, 9, 7, 7, 7, 3, 10, 5])); // Expected output: [8, 9, 7, 7, 10]