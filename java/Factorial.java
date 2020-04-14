class Factorial {
	
	public static void main(String[] args) {
		double n = Double.parseDouble(args[0]);
		double nFactorial = 1;
		while (n > 1) {
			nFactorial *= n;
			n--;
		}
		System.out.println(nFactorial);
	}
}