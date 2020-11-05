import javax.swing.*;  
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;

class ListSwitch extends JFrame {

	private String numbersTo9[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};
	private String numbersTo18[] = {"10", "11", "12", "13", "14", "15", "16", "17", "18"};

	public ListSwitch(String title) {

		super(title);

		JPanel mainPanel = new JPanel();
		mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

		JButton button1 = new JButton("1-9");
		mainPanel.add(button1);

		JButton button2 = new JButton("10-18");
		mainPanel.add(button2);

		DefaultListModel<String> listModel = new DefaultListModel<String>();
		JList list1 = new JList<String>(listModel);
		mainPanel.add(list1);

		button1.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				listModel.clear();
				for (String num: numbersTo9) {
					listModel.addElement(num);
				}
			}
		});
		
		button2.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				listModel.clear();
				for (String num: numbersTo18) {
					listModel.addElement(num);
				}
			}
		});

		this.add(mainPanel);

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(400, 400);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		new ListSwitch("JList Switch Test");
	}
}