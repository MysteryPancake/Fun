class NonStaticProgram {

	public void print() { // no static
		System.out.print("BRUH");
	}

	public static void main(String[] args) {
		NonStaticProgram bruhProgram = new NonStaticProgram();
		bruhProgram.print();
	}
}