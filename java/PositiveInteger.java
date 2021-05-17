import java.util.Scanner;

public class PositiveInteger {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		int x = -1;
		while (x < 0) {
			System.out.print("Please input a positive integer number N: ");
			try {
				x = Integer.parseInt(scan.nextLine());
			} catch (Exception e) {}
		}
	}
}