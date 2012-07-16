# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/var/www/disney_permit_scraper/shared/log/cron_log.log"

every :hour do
  command "ruby /var/www/disney_permit_scraper/current/get_recent_permits.rb"
end
