import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Font;
import java.awt.event.*;
import java.util.*;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;

class VisualTowerOfHanoi extends JPanel implements ActionListener {

	private static Font font = new Font("Serif", Font.PLAIN, 24);
	// Create 3 pegs containing disks (integers)
	private static Stack<Integer> peg1 = new Stack<Integer>();
	private static Stack<Integer> peg2 = new Stack<Integer>();
	private static Stack<Integer> peg3 = new Stack<Integer>();
	// otherMove is used to ensure the moves occur one by one
	private static boolean otherMove = true;
	// Label displays current move and rule behind it
	private static String label = "";
	private static int moves = 0;
	// N can be any number
	private static int n = 6;
	// Timer limits how fast it goes
	private Timer timer;

	public static void main(String[] args) {
		JFrame frame = new JFrame("Restricted Tower Of Hanoi");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel canvas = new VisualTowerOfHanoi();
		canvas.setDoubleBuffered(true);
		canvas.setPreferredSize(new Dimension(1024, 256));
		frame.add(canvas);
		frame.pack();
		frame.setVisible(true);
		// Create n disks with sequential sizes (disks are integers of their size)
		for (int i = n; i > 0; i--) {
			peg1.push(i);
		}
	}

	private void makeMove() {
		if (peg3.size() < n) {
			if (otherMove) {
				// Firstly, perform the valid move between disks 1 and 2
				if (peg2.empty() || (peg1.size() != 0 && peg2.peek() > peg1.peek())) {
					peg2.push(peg1.pop());
					label = "Moved 1 to 2 (placed a disk on the middle peg)";
				} else {
					peg1.push(peg2.pop());
					label = "Moved 2 to 1 (moved a disk from the middle peg)";
				}
				moves++;
			} else {
				// Secondly, perform the valid move between disks 2 and 3
				if (peg3.empty() || (peg2.size() != 0 && peg3.peek() > peg2.peek())) {
					peg3.push(peg2.pop());
					label = "Moved 2 to 3 (moved a disk from the middle peg)";
				} else {
					peg2.push(peg3.pop());
					label = "Moved 3 to 2 (placed a disk on the middle peg)";
				}
				moves++;
			}
			otherMove = !otherMove;
		}
	}

	private void drawPeg(Stack<Integer> peg, int i, Graphics g, int diskHeight) {
		int height = diskHeight;
		int x = (getWidth() / 6) + (getWidth() * i) / 3;
		int pegWidth = getWidth() / 16 / n;
		g.setColor(Color.black);
		g.fillRect(x - pegWidth / 2, getHeight() / 2, pegWidth, getHeight() / 2);
		for (int diskSize: peg) {
			int diskWidth = diskSize * getWidth() / 3 / n;
			g.setColor(Color.getHSBColor((float)(diskSize - 1) * 0.1f, 1, 1));
			g.fillRect(x - diskWidth / 2, getHeight() - height, diskWidth, diskHeight);
			height += diskHeight;
		}
	}

	public void actionPerformed(ActionEvent ev) {
		// Only make a move when the timer allows it
		if (ev.getSource() == timer) {
			makeMove();
			repaint();
		}
	}

	public void paintComponent(Graphics g) {
		if (timer == null) {
			// Force a minimum of 1000 milliseconds (1 second) between moves
			timer = new Timer(1000, this);
			timer.start();
		}
		super.paintComponent(g);
		int diskHeight = getHeight() / n / 3;
		drawPeg(peg1, 0, g, diskHeight);
		drawPeg(peg2, 1, g, diskHeight);
		drawPeg(peg3, 2, g, diskHeight);
		g.setFont(font);
		g.setColor(Color.black);
		g.drawString(label, 16, 32);
		g.drawString("Moves = " + moves, 16, 64);
		g.drawString("n = " + n, 16, 96);
	}
}