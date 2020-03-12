import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JPanel;

class Art extends JPanel {

	public static void main(String[] args) {
		JFrame frame = new JFrame("Art");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new Art();
		canvas.setDoubleBuffered(true);
		canvas.setPreferredSize(new Dimension(512, 512));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
	}

	private static Random r = new Random();

	public void paintComponent(Graphics g) {
		for (int i = 0; i < getHeight(); i++) {
			float scaled = (float)i / getHeight();
			g.setColor(new Color(1 - scaled, r.nextFloat(), scaled));
			g.fillRect(0, i, getWidth(), 1);
		}
		/*for (int j = 0; j < 128; j++) {
			g.setColor(Color.white);
			g.drawRect(r.nextInt(getWidth()), r.nextInt(getHeight()), r.nextInt(256), r.nextInt(256));
		}*/
		repaint();
	}
}