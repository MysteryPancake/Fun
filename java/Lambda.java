class Lambda {

	private static int i = 0;

	interface StringBuilder {
		String run(String s);
	}

	public Lambda() {
		System.out.println(this);
	}

	public String toString() {
		StringBuilder e = i -> this + i;
		if (i > 10) return "bruh";
		return e.run(String.valueOf(i++));
	}

	public static void main(String[] args) {
		new Lambda();
	}
}