# encoding: utf-8
class PermitViewer < Sinatra::Application
  get '/' do
    haml :index
  end

  get '/view' do
    @permits = PermitScrape::get_permits('07/01/2012','07/15/2012')
    haml :view
  end
end
