task :get_current_day do
  require 'date'
  require 'open-uri'
  from = Date.today - 1
  fm = from.strftime('%m')
  fd = from.strftime('%d')
  fy = from.strftime('%Y')
  to = Date.today
  tm = to.strftime('%m')
  td = to.strftime('%d')
  ty = to.strftime('%Y')
  url = "http://permits.nerdbrigade.org/#{fm}/#{fd}/#{fy}/#{tm}/#{td}/#{ty}"
  puts "Opening #{url}"
  open url
end
