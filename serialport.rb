require 'rubygems'
require 'serialport'
require 'pubnub'

class ArduinoAlarm
  attr_accessor :sp, :pubnub

  #params for serial port
  PORT_STR = '/dev/ttyACM0'
  BAUD_RATE = 9600
  DATA_BITS = 8
  STOP_BITS = 1
  PARITY = SerialPort::NONE
  
  #Pubnub keys
  SUBSCRIBE_KEY = ENV['PUBNUB_SUB_KEY']
  PUBLISH_KEY = ENV['PUBNUB_PUB_KEY']
  
  def initialize
    puts 'Initializing...'
    @sp = SerialPort.new(PORT_STR, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
    @pubnub = Pubnub.new(subscribe_key: SUBSCRIBE_KEY, publish_key: PUBLISH_KEY)
  end

  def listen
    puts 'Listening...'

    while true do
      message = sp.gets
      message.chomp!
      puts message
      
      case message
        when 'Loud sound detected!'
          publish('loud_noise_notifications', message)
      end
    end
  end 
  
  private

  def publish(channel, message)
    pubnub.publish(
      channel: channel,
      message: { text: message }
    ) do |envelope|
      puts envelope.status
    end
  end
end

arduino_alarm = ArduinoAlarm.new
arduino_alarm.listen
