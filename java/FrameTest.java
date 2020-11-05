import java.awt.*;
import javax.swing.*;

class FrameTest extends JFrame {

	public FrameTest(String title) {

		super(title);

		JLabel hello = new JLabel();
		hello.setText("Hello world");
		this.add(hello);

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(1280, 720);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		new FrameTest("Frame Test");
	}
}