
// Load Wi-Fi library
#include <ESP8266WiFi.h>

#ifndef UNIT_TEST
#include <Arduino.h>
#endif
#include <IRremoteESP8266.h>
#include <IRsend.h>
#define IR_LED 4  // ESP8266 GPIO pin to use. Recommended: 4 (D2).

IRsend irsend(IR_LED);  // Set the GPIO to be used to sending the message.


uint64_t Standby = 0x10E03FC;
uint64_t RadioTuneUp= 0x10E21DE;
uint64_t RadioTuneDown= 0x10EA15E;
uint64_t RadioPScan= 0x10E6996;
uint64_t RadioTuner1= 0x10EE11E;
uint64_t RadioTuner2= 0x10E11EE;
uint64_t RadioTuner3= 0x10E916E;
uint64_t RadioTuner4= 0x10E51AE;
uint64_t RadioTuner5= 0x10ED12E;
uint64_t RadioTuner6= 0x10E31CE;
uint64_t RadioTuner7= 0x10EB14E;
uint64_t RadioTuner8= 0x10E718E;
uint64_t RadioTuner9= 0x10EB946;
uint64_t RadioTuner0= 0x10E7986;
uint64_t CdDisc= 0x10E0AF5;
uint64_t CdPlay= 0x10E40BF;
uint64_t CdPause = 0x10EC03F;
uint64_t CdStop= 0x10E807F;
uint64_t CdSearchLeft= 0x10EE01F;
uint64_t CdSearchRight= 0x10E609F;
uint64_t CdSkipLeft= 0x10EA05F;
uint64_t CdSkipRight= 0x10E20DF;
uint64_t Cd= 0x10E23DC;
uint64_t Tuner= 0x10EC33C;
uint64_t TapeMon= 0x10EB34C;
uint64_t TvAux= 0x10E738C;
uint64_t VCR1= 0x10E53AC;
uint64_t VCR2= 0x10ED32C;
uint64_t VolumeUp= 0x10EE31C;
uint64_t VolumeDown= 0x10E13EC;
uint64_t Display= 0x10E3BC4;
uint64_t Sleep= 0x10EDB24;
uint64_t Mute= 0x10E837C;




// Replace with your network credentials
const char* ssid     = "keepAway";
const char* password = "cometa1997";

// Set web server port number to 80
WiFiServer server(80);

// Variable to store the HTTP request
String header;

// Auxiliar variables to store the current output state
String output5State = "off";
String output4State = "off";

// Assign output variables to GPIO pins


void setup() {
  Serial.begin(115200);
  irsend.begin();
  

  // Connect to Wi-Fi network with SSID and password
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
}

void loop(){
  WiFiClient client = server.available();   // Listen for incoming clients

  if (client) {                             // If a new client connects,
    Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    while (client.connected()) {            // loop while the client's connected
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            // turns the GPIOs on and off
            if (header.indexOf("GET /Standby") >= 0) {
    
        Serial.println("NEC");
        irsend.sendNEC(Standby, 32);
              
            } else if (header.indexOf("GET /VolumeUp") >= 0) {
              Serial.println("NEC");
        irsend.sendNEC(VolumeUp, 32);
              
            } else if (header.indexOf("GET /VolumeDown") >= 0) {
             Serial.println("NEC");
        irsend.sendNEC(VolumeDown, 32);
              
            } else if (header.indexOf("GET /VCR1") >= 0) {
              Serial.println("NEC");
        irsend.sendNEC(VCR1, 32);
              
            
      } else if (header.indexOf("GET /VCR2") >= 0) {
              Serial.println("NEC");
              irsend.sendNEC(VCR2, 32);
              
            }
            
            // Display the HTML web page
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            // CSS to style the on/off buttons 
            // Feel free to change the background-color and font-size attributes to fit your preferences
            client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            client.println(".button { background-color: #195B6A; border: none; color: white; padding: 16px 40px;");
            client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            client.println(".button2 {background-color: #77878A;}</style></head>");
            
            
            // Web Page Heading
            client.println("<body><h1>Harman/Kardon Wireless Control</h1>");
            
       
            
            client.println("<p><a href=\"/Standby\"><button class=\"button\">Standby</button></a></p>");
      client.println("<p><a href=\"/VolumeUp\"><button class=\"button\">VolumeUp</button></a></p>");
      client.println("<p><a href=\"/VolumeDown\"><button class=\"button\">VolumeDown</button></a></p>");
            client.println("<p><a href=\"/VCR1\"><button class=\"button\">VCR1</button></a></p>");
      client.println("<p><a href=\"/VCR2\"><button class=\"button\">VCR2</button></a></p>");


            client.println("</body></html>");
            
            // The HTTP response ends with another blank line
            client.println();
            // Break out of the while loop
            break;
        }
      
           else { // if you got a newline, then clear currentLine
            currentLine = "";
          

        } 
      }else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}
