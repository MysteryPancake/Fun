import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.*;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.util.*;
import javax.swing.JFrame;
import javax.swing.JPanel;

class Bees extends JPanel {

	private static Random r = new Random();
	private static BufferedImage img;

	private static class Bee {
		private double x;
		private double y;
		private double xVel = 0;
		private double yVel = 0;
		private double xAcc = 0;
		private double yAcc = 0;
		private boolean right = true;;
		private int size = 8;
		//private double speed = 0;
		private double drag = 0.1;
		public Bee(double xPos, double yPos) {
			x = xPos;
			y = yPos;
			right = r.nextInt(2) == 0;
			size = 8 + r.nextInt(16);
			//speed = r.nextDouble() * 0.01;
		}
		public void draw(Graphics g, double targetX, double targetY) {
			g.drawImage(img, (int)x, (int)y, right ? size : -size, size, null);
			xAcc = r.nextDouble() * (targetX - x) * 0.01;
			yAcc = r.nextDouble() * (targetY - y) * 0.01;
			xVel += xAcc * drag + (r.nextDouble() - 0.5);
			yVel += yAcc * drag + (r.nextDouble() - 0.5);
			x += xVel * drag;
			y += yVel * drag;
		}
	}

	private static List<Bee> bees = new ArrayList<Bee>();

	public static void main(String[] args) throws IOException {
		img = ImageIO.read(new File("C:\\Users\\MysteryPancake\\Desktop\\Fun\\bee.png"));
		JFrame frame = new JFrame("Bees");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new Bees();
		canvas.setPreferredSize(new Dimension(512, 512));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
		for (int i = 0; i < 256; i++) {
			bees.add(new Bee(r.nextInt(canvas.getWidth()), r.nextInt(canvas.getHeight())));
		}
	}

	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		Iterator<Bee> iter = bees.iterator();
		while (iter.hasNext()) {
			iter.next().draw(g, getWidth() / 2, getHeight() / 2);
		}
		repaint();
	}
}