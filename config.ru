set :environment, :production
disable :run


require File.join(File.dirname(__FILE__), 'permit_viewer')
run Sinatra::Application
