#!/usr/bin/env ruby
# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'logger'
require 'mysql'
require 'haml'

#************ DB SETUP ************

configure :development do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'root' ,
    :password => 'groovy',
    :database => 'permits_development'})  

end

configure :production do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'daybreaker' ,
    :password => 'groovy!2',
    :database => 'permits_production'})  
end

#*********** END DB SETUP ***********

require_relative 'lib/permit_scrape'
require_relative 'lib/permit_model'

get '/' do
  haml :index
end

get '/view' do
  @permits = PermitScrape.new.get_permits('07/01/2012','07/15/2012')
  haml :view
end
