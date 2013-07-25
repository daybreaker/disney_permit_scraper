#!/usr/bin/env ruby
# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'logger'
require 'mysql'
require 'haml'
require 'active_support'

#************ DB SETUP ************

configure :development do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'root' ,
    :password => 'groovy!2',
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
  set_cookie("true", {
    :domain => "or.occompt.com",
    :path => "/recorder",
    :expires => Date.new
  })

  haml :index
end

post '/view' do
  from = DateTime.strptime(params[:from_date], "%m/%d/%Y")
  to = DateTime.strptime(params[:to_date], "%m/%d/%Y")
  @permits = Permit.all(:rec_date => (from..to), :order => [ :rec_date.desc ])
  haml :view
end

get '/:fm/:fd/:fy/:tm/:td/:ty' do
  PermitScrape.new.get_permits("#{params[:fm]}/#{params[:fd]}/#{params[:fy]}","#{params[:tm]}/#{params[:td]}/#{params[:ty]}")
  "Permits Updated"
end

