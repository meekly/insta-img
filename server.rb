#!/usr/bin/ruby
# encoding: utf-8

require 'sinatra'
require 'find'
require 'time'
require 'json'
require 'fileutils'
require 'time'
require 'mini_magick'

# A bunch of settings
set :static, true
set :bind, '0.0.0.0'
set :port, 3030

PUBLIC_FOLDER = File.dirname(__FILE__) + '/public'
USE_IMAGE_MAGICK = (ARGV[0] == 'IM')

get %r{/(users?)?} do
  files = Dir.entries(PUBLIC_FOLDER)

  users = []
  files.each do |file|
    users.push(file) if File.directory?(File.join(PUBLIC_FOLDER, file)) and file !~ /^\./
  end
  users.sort!

  erb :index, :locals => {
        :users => users
      }
end

get '/register' do
  erb :register
end

post '/register' do
  # When user registers, he'll have a directory created
  user = params[:user]
  user_folder = File.join(PUBLIC_FOLDER, user)

  if File.exist?(user_folder) then
    erb :already_registered, :locals => {
          :user => user,
        }
  else
    Dir.mkdir(user_folder)
    # Show user's page with no images
    erb :user, :locals => {
          :user => user,
        }
  end
end

get '/user/:name' do
  images = []
  user_folder = File.join(PUBLIC_FOLDER, params[:name])
  if ! File.exist?(user_folder) then
    return erb :error, :locals => {
          :message => "No such a user '#{params[:name]}'."
        }
  end
  Find.find(user_folder) do |path|
    suffix = USE_IMAGE_MAGICK ? 'min300' : ''
    images.push(path.sub(PUBLIC_FOLDER, '')) \
      if path =~ /(jpg|png|jpeg|gif|bmp)#{suffix}$/
  end

  # Sorting by timestamp
  images.sort!

  # Show user's images
  erb :user, :locals => {
        :user => params[:name],
        :images => images,
      }
end

post '/user/:name', :provides => :json  do
  # Posting an image to user
  dest_filename = File.join(PUBLIC_FOLDER,
                            params[:name],
                            Time.now.utc.to_s + params[:file][:filename],
                           )
  # ImageMagic code:

  FileUtils.cp(params[:file][:tempfile], dest_filename)
  puts ARGV
  if USE_IMAGE_MAGICK then
    puts 'USING IMAGE MAGICK'
    image = MiniMagick::Image.open(dest_filename)
    image.resize '300x300'
    image.write("#{dest_filename}min300")
  end
  200
end

get '/user/:user/:image' do

  user = params[:user]
  image = params[:image]
  big_image = image.gsub('min300', '')
  image_path = File.join('/', user, image)
  big_image_path = File.join('/', user, big_image)


  # Show user's image
  erb :user_image, :locals => {
        :user => user,
        :image => File.exist?(big_image_path) ? big_image_path : image_path,
      }
end
