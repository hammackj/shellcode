#!/usr/bin/env ruby -wKU

def reverse_bytes hex
	x = hex.scan(/../).reverse.join("")
end

hex = String.new

ARGV[0].split(".").each do |c|
	hex << sprintf("%02X", c)
end

puts "Got #{reverse_bytes(hex)}"
puts "Need 0100007F"

