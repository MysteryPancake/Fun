// JavaScript version of a solution to the change-making problem
// From "Introduction to The Design and Analysis of Algorithms" by Anany Levitin

function ChangeMaking(D, n) {

	const header = Array.from({length: n + 1}, (v, i) => i).join("\t");

	const F = [0];
	console.log("F[0] = 0");
	console.log(header + "\n" + F.join("\t"));

	for (let i = 1; i <= n; i++) {

		let temp;
		let j = 1;

		let str = `F[${i}] = min(`;

		while (j <= D.length && i >= D[j - 1]) {

			const current = F[i - D[j - 1]];
			if (temp === undefined || current < temp) {
				temp = current;
			}

			if (j > 1) str += ", ";
			str += `F[${i} - ${D[j - 1]}]`;

			j++;
		}

		F[i] = temp + 1;
		console.log(`${str}) + 1 = ${F[i]}`);
		console.log(`${header}\n${F.join("\t")}`);
	}

	console.log(`The solution is ${F[n]} coins`);
	return F;
}

// Example: Optimal solution to get $6 is 2 x $3
ChangeMaking([1, 3, 4], 6);