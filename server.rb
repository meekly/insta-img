#!/usr/bin/ruby

require 'sinatra'
require 'find'
require 'time'

# A bunch of settings
set :static, true
set :bind, '0.0.0.0'
set :port, 3030

PUBLIC_FOLDER = File.dirname(__FILE__) + '/public'

get %r{/(users?)?} do
  erb :index
end

post '/register' do
  # When user registers, he'll have a directory created
  user = params[:user]
  user_folder = File.join(PUBLIC_FOLDER, user)

  if File.file?(user_folder) then
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
  if ! File.directory?(user_folder) then
    return erb :error, :locals => {
          :message => "No such a user '#{params[:name]}'."
        }
  end
  Find.find(user_folder) do |path|
    images.push(path.sub(PUBLIC_FOLDER, ''))
  end

  # Sorting by timestamp
  images.sort! do |a, b|
    tsa = a.match(/(\d+-\d+-\d+_\d+-\d+-\d+)/).captures
    tsb = b.match(/(\d+-\d+-\d+_\d+-\d+-\d+)/).captures

    ta = Time.strptime(tsa, '%d-%m-%Y_%H-%M-%S')
    tb = Time.strptime(tsb, '%d-%m-%Y_%H-%M-%S')

    ta <=> tb
  end

  # Show user's images
  erb :user, :locals => {
        :user => params[:name],
        :images => images,
      }
end

get '/user/:name/:image' do

  user = params[:user]
  image = params[:image]
  image_path = File.join(PUBLIC_FOLDER, user, image)

  # Show user's image
  erb :user_image, :locals => {
        :user => user,
        :image => image_path,
      }
end
