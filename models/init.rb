# encoding: utf-8
require 'data_mapper'
require 'mysql'

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


require_relative 'permits'
