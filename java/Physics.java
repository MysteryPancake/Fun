import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import javax.swing.JFrame;
import javax.swing.JPanel;

class Physics extends JPanel {
	
	private static int size = 32;
	private double xPos = 256;
	private double yPos = 0;
	private double xVel = 1;
	private double yVel = 0;
	private double yAcc = 0.005;
	private double decay = 0.9;

	public static void main(String[] args) {
		JFrame frame = new JFrame("Physics");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new Physics();
		canvas.setPreferredSize(new Dimension(512, 512));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
	}

	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		g.setColor(Color.black);
		g.fillOval((int)xPos, (int)yPos, size, size);
		xPos += xVel;
		yVel += yAcc;
		yPos += yVel;
		if (xPos + size >= getWidth()) {
			xVel *= -decay;
			xPos = getWidth() - size;
		} else if (xPos < 0) {
			xVel *= -decay;
			xPos = 0;
		}
		if (yPos + size >= getHeight()) {
			yVel *= -decay;
			yPos = getHeight() - size;
		}
		repaint();
	}
}