/****************************************
Example Sound Level Sketch for the 
Adafruit Microphone Amplifier
****************************************/

const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
const int threshold = 80; // peak-to-peak sound level threshold
unsigned int sample;

void setup() {
   Serial.begin(9600);
}

void loop() {
   unsigned long startMillis= millis();  // Start of sample window
   unsigned int peakToPeak = 0;   // peak-to-peak level

   unsigned int signalMax = 0;
   unsigned int signalMin = 1024;

   // collect data for 50 mS
   while (millis() - startMillis < sampleWindow) {
      sample = analogRead(0);
      // toss out spurious readings
      if (sample < 1024) {
         if (sample > signalMax) {
            signalMax = sample;  // save just the max levels
         } else if (sample < signalMin) {
            signalMin = sample;  // save just the min levels
         }
      }
   }
   peakToPeak = signalMax - signalMin;  // max - min = peak-peak amplitude

   if (peakToPeak > 80) {
     Serial.println("Loud sound detected!");
     Serial.println(peakToPeak);
   }
}
