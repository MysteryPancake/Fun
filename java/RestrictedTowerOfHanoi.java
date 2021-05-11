import java.util.*;

class RestrictedTowerOfHanoi {

	// Create 3 pegs containing disks (integers)
	private static Stack<Integer> peg1 = new Stack<Integer>();
	private static Stack<Integer> peg2 = new Stack<Integer>();
	private static Stack<Integer> peg3 = new Stack<Integer>();

	public static void main(String[] args) {
		// n can be any number
		int n = 6;
		// Create n disks with sequential sizes (disks are integers of their size)
		for (int i = n; i > 0; i--) {
			peg1.push(i);
		}
		int moves = 0;
		while (peg3.size() < n) {
			// Firstly, perform the valid move between disks 1 and 2
			if (peg2.empty() || (peg1.size() != 0 && (peg2.peek() > peg1.peek()))) {
				peg2.push(peg1.pop());
				System.out.print("1 to 2, ");
			} else {
				peg1.push(peg2.pop());
				System.out.print("2 to 1, ");
			}
			moves++;
			// Secondly, perform the valid move between disks 2 and 3
			if (peg3.empty() || (peg2.size() != 0 && (peg3.peek() > peg2.peek()))) {
				peg3.push(peg2.pop());
				System.out.print("2 to 3, ");
			} else {
				peg2.push(peg3.pop());
				System.out.print("3 to 2, ");
			}
			moves++;
		}
		// Game complete
		System.out.println("Peg 3 full!");
		System.out.println("Took " + moves + " moves!");
	}
}