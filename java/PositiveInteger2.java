import java.util.Scanner;

public class PositiveInteger2 {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		int x = -1;
		while (x < 0) {
			System.out.print("Please input a positive integer number N: ");
			if (scan.hasNextInt()) {
				x = scan.nextInt();
			}
			scan.nextLine(); // Clear buffer
		}
	}
}