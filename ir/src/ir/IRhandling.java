package ir;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public  class IRhandling {
	static Remote remote;

	public IRhandling(Remote remote) {
		IRhandling.remote = remote;	
	}
	public static Remote getRemote() {
		return remote;
	}
	public static void setRemote(Remote remote) {
		IRhandling.remote = remote;
	}
	public static boolean standby() {
		sendCommand("KEY_STANDBY","harman");

		return true;
	}
	public static boolean mute() {
		sendCommand("KEY_MUTE","harman");

		return true;
	}
	public static boolean volUp() {
		sendCommand("KEY_VOLUME_UP","harman");

		return true;
	}
	public static boolean volDown() {
		sendCommand("KEY_VOLUME_DOWN","harman");

		return true;
	}
	public static boolean vcr1() throws Exception {
		
		sendCommand("KEY_VCR1","harman");

		return true;
	}
	public static  boolean vcr2() throws Exception {
		sendCommand("KEY_VCR2","harman");
		return true;
	}
	public static boolean checkStatus() throws Exception {
		String result=null;


		String send = " cat /proc/asound/card0/pcm0p/sub0/status"; // this command shows if there is anything playing
		ProcessBuilder process = new ProcessBuilder("/bin/bash", "-c", send);// builds the command 

		BufferedReader reader = new BufferedReader(new InputStreamReader(process.start().getInputStream()));// runs command and gets console output
		StringBuilder builder = new StringBuilder();
		String line = null;
		while ( (line = reader.readLine()) != null) {// composes output if is more than one line
			builder.append(line);
		}
		result = builder.toString();
		//System.out.println(result);


		if(result.equals("closed"))
			return false;
		else if(result.equals(null))
			throw new Exception();
		else
			return true;
	}

	private static void sendCommand(String command, String remoteName) {
		try {
			String send = "irsend SEND_ONCE "+ remoteName +" "+ command;
			System.out.println(send);
			ProcessBuilder processBuilder = new ProcessBuilder("/bin/bash", "-c", send);
			processBuilder.start();
		}
		catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	
		
		
		
		
	}

	
	
	
	
	






