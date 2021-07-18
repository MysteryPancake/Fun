// This is a simulation of a gambling game
// It finds the most probable outcome out of 100000 attempts

let wins = 0;
let losses = 0;
let evens = 0;

for (let i = 0; i < 100000; i++) { // Brute force 100000 times
	let money = 1; // Thanks Caleb
	for (let j = 0; j < 4; j++) { // Play the game 4 times
		money--; // Bet 1 dollar
		if (Math.floor(Math.random() * 4) === 1) { // Draw a random card (1 in 4 chance)
			money += 3; // Gain 3 times the bet
		}
	}
	if (money > 0) {
		wins++;
	} else if (money < 0) {
		losses++;
	} else {
		evens++;
	}
}

console.log(`WINS: ${wins}`);
console.log(`LOSSES: ${losses}`);
console.log(`EVENS: ${evens}`);