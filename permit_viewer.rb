#!/usr/bin/env ruby
# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'logger'
require 'mysql'
require_relative 'lib/permit_scrape'

#************ DB SETUP ************

configure :development do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'root' ,
    :password => '',
    :database => 'permits_development'})  

  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'daybreaker' ,
    :password => 'groovy!2',
    :database => 'permits_production'})  
end

DataMapper.finalize.auto_upgrade!

#*********** END DB SETUP ***********

#*********** MODELS *****************

class Permit
  include DataMapper::Resource
  property :id,         Serial
  property :document_id,String, :unique_index => true
  property :type,       String
  property :grantor,    String
  property :grantee,    String
  property :legal,      String
  property :detail_url, String
  property :node_id,    String
  property :pdf_url,    String
  property :status,     Flag[:new, :verified_bad, :verified_good, :unsure]
  property :notes,      String
  property :created_at, DateTime
  
  
end

#********* END MODELS ***************


get '/' do
  haml :index
end

get '/view' do
  @permits = PermitScrape.get_permits('07/01/2012','07/15/2012')
  haml :view
end
