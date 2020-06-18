const jobMatrix = [
	[4, 8, 8, 3, 4],
	[9, 5, 5, 2, 7],
	[4, 2, 4, 1, 3],
	[7, 9, 6, 5, 8],
	[3, 6, 4, 4, 5]
];

const workerNames = ["Anne", "Bob", "Carol", "Dave", "Ethan"];

let result = "";

function traverseSubtree(index, takenJobs, level, totalCost) {
	for (let i = 0; i < jobMatrix[index].length; i++) {
		if (takenJobs.indexOf(i) !== -1) continue;
		const thisCost = totalCost + jobMatrix[index][i];
		result += "\r\n" + "\t".repeat(level) + workerNames[index] + ": Task " + (i + 1) + "\nSum = " + thisCost;
		if (jobMatrix[index + 1]) {
			traverseSubtree(index + 1, takenJobs + i.toString(), level + 1, thisCost);
		}
	}
}

for (let i = 0; i < jobMatrix[0].length; i++) {
	if (i > 0) {
		result += "\r\n";
	}
	const thisCost = jobMatrix[0][i];
	result += workerNames[0] + ": Task " + (i + 1) + "\nSum = " + thisCost;
	traverseSubtree(1, i.toString(), 1, thisCost);
}

console.log(result);