// Based on https://www.youtube.com/watch?v=F6J3ZmXkMj0

// Using Jacobi and Gauss-Seidel to solve these equations:
// 5a - b + 2c = 12
// 3a + 8b - 2c = -25
// a + b + 4c = 6

let a = 0, b = 0, c = 0;
let jacobi = false;

function calc_a() { return (12 + b - 2*c) / 5; }
function calc_b() { return (-25 - 3*a + 2*c) / 8; }
function calc_c() { return (6 - a - b) / 4; }

for (let i = 0; i < 50; ++i) {
	if (jacobi) {
		const new_a = calc_a();
		const new_b = calc_b();
		const new_c = calc_c();
		a = new_a;
		b = new_b;
		c = new_c;
	} else {
		a = calc_a();
		b = calc_b();
		c = calc_c();
	}
}

console.log("A = " + a);
console.log("B = " + b);
console.log("C = " + c);

console.log("Expected 12, got " + (5*a - b + 2*c));
console.log("Expected -25, got " + (3*a + 8*b - 2*c));
console.log("Expected 6, got " + (a + b + 4*c));