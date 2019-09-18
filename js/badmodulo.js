function modulus(x, y) {
	var result = x / y;
	var decimals = result - Math.floor(result);
	return y * decimals;
}
