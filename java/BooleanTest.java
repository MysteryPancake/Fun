class BooleanTest {

	public static void main(String[] args) {
		boolean p = true;
		boolean q = false;
		boolean r = true;
		System.out.println(p || q == q || p);
		System.out.println(p || (q || r) == (p || q) || r);
		System.out.println(p || p == p);
		System.out.println(p || false == p);
		System.out.println(p || (q == r) == (p || q) == (p || r));
	}
}