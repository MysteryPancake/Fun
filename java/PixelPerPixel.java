import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JPanel;

class PixelPerPixel extends JPanel {

	public static void main(String[] args) {
		JFrame frame = new JFrame("Pixel Per Pixel");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new PixelPerPixel();
		canvas.setDoubleBuffered(true);
		canvas.setPreferredSize(new Dimension(512, 512));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
	}

	private static Random r = new Random();

	public void paintComponent(Graphics g) {
		for (int i = 0; i < getWidth(); i++) {
			for (int j = 0; j < getHeight(); j++) {
				g.setColor(new Color(r.nextFloat(), r.nextFloat(), r.nextFloat()));
				g.fillRect(i, j, 1, 1);
			}
		}
		repaint();
	}
}