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
      file.puts "#{parsed_response}=\n"
    elsif array[-1].to_i > array[-2].to_i
      file.puts "#{parsed_response}⬈\n"
    else
      file.puts "#{parsed_response}⬊\n"
    end
  end

  file.close
  sleep(time_start - time_now)
end
