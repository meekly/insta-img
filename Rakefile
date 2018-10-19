require 'find'

task :default => [:bundle, :start]

task :bundle => ['Gemfile'] do
    sh 'bundle install'
end

file 'Gemfile'


task :start do
    ruby 'server.rb'
end

task :start_useim do
  ruby 'server.rb IM'
end

task :clean do
  Find.find('.') do |path|
    if /.*~/ =~ path then
      rm path
    end
  end

  Dir.glob('public/user*/*').each do |path|
    rm path
  end
end

task :minify do
  Dir.glob('public/user*/*').each do |path|
    ruby 'minify.rb', path
  end
end
