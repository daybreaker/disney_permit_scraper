#!/usr/bin/env ruby
# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'logger'
require 'haml'

# http://stackoverflow.com/questions/5015471/using-sinatra-for-larger-projects-via-multiple-files

class PermitViewer < Sinatra::Application
  
  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true
  end

  configure :development do
    # ...
  end
  
  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
end

require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'

