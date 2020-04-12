import java.util.Scanner;

class Ape {

	public static void main(String[] args) {

		Scanner s = new Scanner(System.in);

		System.out.println("Who's out here having dinner?");
		System.out.println("Who could it be?");
		String havingDinner = s.nextLine();

		if (havingDinner.equals("me")) {

			System.out.println("Whose toes are those?");
			String ownsToes = s.nextLine();

			if (ownsToes.equals("mine")) {

				System.out.println("Who's that great ape right there?");
				String apeName = s.nextLine();

				System.out.println(apeName + ", is it dinner time?");
				System.out.println("Is it dinner time?");
				String dinnerTime = s.nextLine();

				if (dinnerTime.equals("yes")) {
					System.out.println("OH I THINK IT IS");
				}
			}
		}
	}
}