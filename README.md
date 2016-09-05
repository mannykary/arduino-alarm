# Arduino Alarm

This is a proof of concept for an alarm system triggered by a microphone amplifier on an Arduino UNO connected to a Raspberry Pi. It will trigger an alarm on a smartphone when it detects a loud noise (such as a fire alarm).

## Building and Uploading the Arduino Sketch from Raspberry Pi
Instead of using the Arduino IDE, which would run slowly on a Raspberry Pi, we are using the command line to build and upload the sketch from the Pi to the Arduino. Assuming that the Raspberry Pi is running Raspbian, install `arduino-core` and `arduino-mk` using `apt-get`:

````
sudo apt-get install arduino-core arduino-mk
````

Then add your Raspberry Pi user to the `dialout` group so that you will be able to upload the code to the Arduino:

````
sudo usermod -a -G dialout pi
````

Reboot the Pi, and then `cd` back into the `arduino-alarm` directory. Test that the sketch compiles:

````
make
````

If there are no errors, then you can upload the compiled sketch to the Arduino

````
make upload
````

If Ruby and [Bundler](http://bundler.io) are not already installed, install them. I use [RVM](https://rvm.io/) to install Ruby, but you can use `rbenv`, Homebrew (on OS X), or a package manager in Linux (although the latter will install an older stable release of Ruby).

Then run the `serialport.rb` Ruby script

````
ruby serialport.rb
````

Make a loud sound (clapping over the microphone should suffice). The Arduino will send back a message to the console indicating that a loud soud was detected.

##TODO
* Send an HTTP request to a server on Heroku, or use PubNub
* Develop an Android app to receive the HTTP request from Heroku/PubNub, and trigger an alarm notification
* Add other triggers
* Add emergency messaging system
