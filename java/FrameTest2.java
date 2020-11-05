import java.awt.*;
import javax.swing.*;

class FrameTest2 extends JFrame {

	public FrameTest2(String title) {
		
		super(title);

		this.setLayout(null);

		JLabel hello = new JLabel("Hello world");
		hello.setBounds(16, 16, 100, 16);
		this.add(hello);

		DefaultListModel<String> listContents = new DefaultListModel<String>();
		listContents.addElement("shit1");
		listContents.addElement("shit2");
		listContents.addElement("shit3");

		JList list = new JList<String>(listContents);
		
		// JScrollPane is optional but helps later when the list has more items
		JScrollPane scroll = new JScrollPane(list);
		scroll.setBounds(16, 32, 200, 200);
		this.add(scroll);

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(1280, 720);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		new FrameTest("Frame Test 2");
	}
}