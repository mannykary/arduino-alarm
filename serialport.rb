require 'rubygems'
require 'serialport'
require 'pubnub'
 
#params for serial port
port_str = '/dev/ttyACM0'
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

#Pubnub keys
subscribe_key = ENV['PUBNUB_SUB_KEY']
publish_key = ENV['PUBNUB_PUB_KEY']

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
pubnub = Pubnub.new(subscribe_key: subscribe_key, publish_key: publish_key)

while true do
  message = sp.gets
  if message
    message.chomp!
    puts message

    pubnub.publish(
      channel: 'loud_noise_notifications',
      message: { text: message }
    ) do |envelope|
      puts envelope.status
    end
  end
end

