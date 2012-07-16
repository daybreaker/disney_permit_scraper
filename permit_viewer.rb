#!/usr/bin/env ruby
# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'logger'
require 'mysql'

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
  property :title,      String
  property :created_at, DateTime
  property :complete,   Boolean, :default=>false

  validates_present :title
end

#********* END MODELS ***************


get '/' do
  haml :index
end
