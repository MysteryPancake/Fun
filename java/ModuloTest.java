import java.util.Scanner;

class ModuloTest {
	
	private static double mod(double number, double divisor) {
		divisor = Math.abs(divisor);
		if (number < 0) {
			while (-divisor >= number) {
				number += divisor;
			}
		} else {
			while (number >= divisor) {
				number -= divisor;
			}
		}
		return number;
	}

	private static double mod2(double number, double divisor) {
		/* return number - ((int)number / (int)divisor); */
		return number - Math.floor(number / divisor) * divisor;
	}

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		while (true) {
			System.out.print("Number 1: ");
			double n = s.nextDouble();
			System.out.print("Number 2: ");
			double n2 = s.nextDouble();
			System.out.println(mod(n, n2));
			System.out.println(mod2(n, n2));
			System.out.println(n % n2);
		}
	}
}