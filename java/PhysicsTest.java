class PhysicsTest {
	
	private static void clearScreen() {
		try {
			new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		} catch (Exception e) {}
	}
	
	public static void main(String[] args) {
		long t = System.currentTimeMillis();
		boolean droppedFloor = false;
		long floorDrop = t + 4096;
		long end = t + 8192;
		long delay = 32;
		int ground = 8;
		int wall = 64;
		double xPos = 0;
		double yPos = 0;
		double xVel = 2;
		double yVel = 0;
		double yAcc = 0.5;
		double decay = 0.75;
		while (System.currentTimeMillis() < end) {
			try {
				Thread.currentThread().sleep(delay);
			} catch (Exception e) {}
			if (!droppedFloor && System.currentTimeMillis() > floorDrop) {
				ground *= 2;
				droppedFloor = true;
			}
			xPos += xVel;
			yVel += yAcc;
			yPos += yVel;
			if (xPos >= wall) {
				xVel = -xVel;
				xPos = wall - 1;
			} else if (xPos < 0) {
				xVel = -xVel;
				xPos = 0;
			}
			if (yPos >= ground) {
				yVel *= -decay;
				yPos = ground - 1;
			}
			clearScreen();
			for (int i = 0; i < Math.floor(yPos); i++) {
				System.out.println(" ".repeat(wall) + "|");
			}
			System.out.println(" ".repeat((int)xPos) + "O" + " ".repeat(wall - (int)xPos - 1) + "|");
			for (int j = 0; j < ground - Math.floor(yPos) - 1; j++) {
				System.out.println(" ".repeat(wall) + "|");
			}
			System.out.println("-".repeat(wall));
		}
	}
}