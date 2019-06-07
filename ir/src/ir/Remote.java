package ir;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;


public class Remote {
	static ArrayList <String> buttons;
	static String name;
	static String directorio;
	public Remote(String name , String directorio) throws IOException {
		buttons=new ArrayList<String>();
		Remote.directorio=directorio;
		Remote.name=name;
		//if (directorio!=null) {genRemoteButtons(directorio);}
	}
	
	private static void genRemoteButtons(String directorio) throws IOException {
		FileInputStream fstream;
		try {
			fstream = new FileInputStream(directorio);
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
			String strLine;
			//Read File Line By Line
			while ((strLine = br.readLine()) != null)   {
				if(strLine.contains("begin codes")) {
					while (!strLine.trim().equals("end codes")) {
						strLine = br.readLine();
						if(getButtonName(strLine)!=null)
							buttons.add(getButtonName(strLine));
					}
				}
			}
			//Close the input stream
			fstream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	private static String getButtonName(String line) {//return null if no name found
		line = line.replaceAll("\\s+","");
		char [] pp = line.toCharArray();
		String buttonName = "";
		int size=0;
		int i=0;
		while (i<pp.length && pp[i]!= '0' ) {
			size++;
			i++;
		}
		for (int j=0 ; j<size;j++) {
			buttonName = buttonName + pp[j];
		}
		if(!buttonName.equals("endcodes")) {
			return buttonName;
		}
		return null;
	}

	public static ArrayList<String> getButtons() {
		return buttons;
	}

	public void setButtons(ArrayList<String> buttons) {
		this.buttons = buttons;
	}

}
