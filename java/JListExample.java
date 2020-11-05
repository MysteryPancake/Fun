import java.awt.GridLayout;
import javax.swing.*;

class JListExample extends JFrame {

	public JListExample(String title) {

		super(title);

		this.setLayout(new GridLayout(1, 2));

		JList<String> list1 = new JList<>();
		this.add(new JScrollPane(list1));

		JList<String> list2 = new JList<>();
		this.add(new JScrollPane(list2));

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(500, 500);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		new JListExample("JList Example");
	}
}