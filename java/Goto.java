class Goto {

	public static void main(String[] args) {
		go_to(1);
	}

	public static void go_to(int n) {
		switch (n) {
		case 1:
			go_to(4);
			break;
		case 2:
			System.out.print("bruh ");
		case 3:
			System.out.print("moment");
			break;
		case 4:
			go_to(2);
		}
	}
}