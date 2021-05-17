class Bruh { // no static
	public void print() { // no static
		System.out.println("BRUH");
	}
}

class NonStaticClass {
	public static void main(String[] args) {
		Bruh bruhMoment = new Bruh();
		bruhMoment.print();
	}
}