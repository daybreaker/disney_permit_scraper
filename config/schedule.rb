# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/var/www/disney_permit_scraper/shared/log/cron_log.log"

every :hour do
  from = Date.today - 1
  fm = from.strftime('%m')
  fd = from.strftime('%d')
  fy = from.strftime('%Y')
  to = Date.today
  tm = to.strftime('%m')
  td = to.strftime('%d')
  ty = to.strftime('%Y')
  command "curl 'http://permits.nerdbrigade.org/#{fm}/#{fd}/#{fy}/#{tm}/#{td}/#{ty}'"
end
