import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.util.*;
import javax.swing.JFrame;
import javax.swing.JPanel;

class Trace extends JPanel {

	private static Random r = new Random();

	private static int clamp(int x) {
		if (x < 0) {
			return 0;
		} else if (x > 255) {
			return 255;
		} else {
			return x;
		}
	}

	private static class Drawer {
		private int x;
		private int y;
		private int xVel = 0;
		private int yVel = 0;
		private int speed = 1;
		private Color color;
		public Drawer(int xPos, int yPos, Color c) {
			x = xPos;
			y = yPos;
			color = c;
			speed += r.nextInt(3);
		}
		public void draw(Graphics g) {
			g.setColor(new Color(clamp(x - y), r.nextInt(255), clamp(y - x)));
			//g.setColor(color);
			//g.setColor(Color.black);
			//g.fillRect(x, y, 1, 1);
			g.fillRect(x, y, speed, speed);
			//if (r.nextInt(100) > 98) {
				xVel = (r.nextInt(3) - 1) * speed;
				yVel = (r.nextInt(3) - 1) * speed;
			//}
			x += xVel;
			y += yVel;
		}
	}

	private static List<Drawer> drawers = new ArrayList<Drawer>();

	private static Color randomColor() {
		return new Color(r.nextFloat(), r.nextFloat(), r.nextFloat());
	}

	public static void main(String[] args) {
		JFrame frame = new JFrame("Trace");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new Trace();
		canvas.setDoubleBuffered(true);
		canvas.setPreferredSize(new Dimension(300, 300));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
		for (int i = 0; i < 128; i++) {
			drawers.add(new Drawer(canvas.getWidth() / 2, canvas.getHeight() / 2, randomColor()));
		}
	}

	public void paintComponent(Graphics g) {
		Iterator<Drawer> iter = drawers.iterator();
		while (iter.hasNext()) {
			iter.next().draw(g);
		}
		repaint();
	}
}