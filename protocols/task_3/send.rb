#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: true)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

loop do
    channel.default_exchange.publish('ping', routing_key: queue.name)
    puts " [x] Sent 'ping'"
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received from server #{body}"
    channel.default_exchange.publish('ping', routing_key: queue.name)
    puts " [x] Sent 'ping'"
    end
end
connection.close