require 'find'

task :default => [:bundle, :server_start]

task :bundle do
    sh 'bundle install'
end

task :server_start do
    ruby 'server.rb'
end

task :clean do
  Find.find('.') do |path|
    if /.*~/ =~ path then
      rm path
    end
  end
end
