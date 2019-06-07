package ir;
import com.pi4j.io.gpio.GpioController;
import com.pi4j.io.gpio.GpioFactory;
import com.pi4j.io.gpio.GpioPinDigitalInput;
import com.pi4j.io.gpio.RaspiPin;
public class Checker extends Thread{
	boolean causaefecto;
	final GpioController gpio = GpioFactory.getInstance();
	final GpioPinDigitalInput input = gpio.provisionDigitalInputPin(RaspiPin.GPIO_02, "HDMI Sense");

	public void run() {
		while(true) {
			System.out.println("hdmi: "+input.isHigh());
			try {
				Thread.sleep(1000);
				System.out.println();
				System.out.println("spotify:"+ IRhandling.checkStatus());
				if (causaefecto!=IRhandling.checkStatus() && IRhandling.checkStatus()==false && input.isLow()) {
					System.out.println("----------------------------------------------");
					IRhandling.vcr1();
					Thread.sleep(200);
					IRhandling.standby();
					Thread.sleep(200);
					causaefecto = false;
				}else if (causaefecto!=IRhandling.checkStatus() && IRhandling.checkStatus()==true) {

					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++");
					IRhandling.vcr1();
					Thread.sleep(200);
					IRhandling.vcr1();
					Thread.sleep(200);
					causaefecto = true;

				}


			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


		}
	}
}
