ENV['RACK_ENV'] ||= 'development'
require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require_relative 'routes'
require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './models/app'
# May not need sinatra/base

class Ideas < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, Proc.new { File.join(root, "Views") }
  register Sinatra::ActiveRecordExtension
  enable :sessions
  use Rack::MethodOverride

get '/' do
  erb :form
  end

post '/save_image' do

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  erb :show_image
  end
end
