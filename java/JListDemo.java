import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

class JListDemo extends JFrame {

	public JListDemo(String name) {

		super(name);

		// Create the contents of the list
		DefaultListModel<String> listModel = new DefaultListModel<String>();
		listModel.addElement("Bruh");
		listModel.addElement("Moment");
		listModel.addElement("420");

		// Whenever the contents are changed, the following JList will update automatically
		JList list = new JList<String>(listModel);
		// Add list to JFrame
		this.add(list);

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(360, 540);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		JListDemo mainFrame = new JListDemo("JList Demo");
	}
}