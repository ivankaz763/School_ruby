#!/usr/bin/env ruby
require "bundler/setup"
require "bunny"

connection = Bunny.new(host:  'localhost',
port:  '5672',
vhost: '/',
user:  'guest',
pass:  'guest')
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

loop do
  puts ' [*] Waiting for messages from client. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
  puts " [x] Received from client #{body}"
   channel.default_exchange.publish('pong', routing_key: queue.name)
  puts " [x] Sent 'pong'"
  end
rescue Interrupt => _
  connection.close

  exit(0)
end