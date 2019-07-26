# frozen_string_literal: true

require 'httparty'
require 'timeout'

array = []

loop do
  time_now = Time.now
  time_start = time_now + 20
  response = HTTParty.get('https://blockchain.info/ticker')
  parsed_response = response['USD'].values_at('symbol', 'last').join(' ')
  array << response['USD']['last']

  file = File. open('btc_log.txt', 'a')
  if array.size >= 2
    if array[-1] == array[-2]
      file.puts parsed_response + '='
    elsif array[-1].to_i > array[-2].to_i
      file.puts parsed_response + '⬈'
    else
      file.puts parsed_response + '⬊'
    end
  end

  file.close
  sleep(time_start - time_now)
end








# array = []

# loop do

#   time_now = Time.now
#   time_start = time_now + 5
#   response = HTTParty.get('https://blockchain.info/ticker')
#   parsed_response = response['USD'].values_at('symbol', 'last').join(' ')
#   array << response['USD']['last']
#   puts "llllllllll"
#   puts array[-1]
#   puts "l1l1l1l1l1"
#   puts array[-2]
#   if array.size >= 2
#     if array[-1].to_i == array[-2].to_i
#       puts "равны"
#     elsif array[-1].to_i > array[-2].to_i
#       puts "больше"
#     else
#       puts "меньше"
#     end
#   end
#   puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"


#   file = File. open('btc_log.txt', 'a')
#   file.puts "============================"
#   file.puts parsed_response
#   file.puts "============================"
#   file.puts time_now
#   file.puts "++++++++++++++++++++"
#   file.puts array
#   file.puts "++++++++++++++++++++"
#   file.puts (time_start - time_now)
#   file.close
#   sleep(time_start - time_now)
# end
