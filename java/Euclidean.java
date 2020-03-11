class Euclidean {
	public static void main(String[] args) {
		double arg1 = Double.parseDouble(args[0]);
		double arg2 = Double.parseDouble(args[1]);
		double a = Math.max(arg1, arg2);
		double b = Math.min(arg1, arg2);
		double r = 0;
		while (b != 0) {
			r = a % b;
			a = b;
			b = r;
		}
		System.out.println(a);
	}
}