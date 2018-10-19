#!/usr/bin/env ruby

path = ARGV[0]

file = File.join(Dir.pwd, path)
return 1 if ! File.exist?(file)
puts "File given: #{ARGV[0]}"

##
# We should check if this file has a minified version
# (or is a minified version itself)

return 0 if file =~ /min300$/
return 0 if File.exist?(File.join(file, 'min300'))

puts 'File requires minification'
##
# We didn't find a minified version of this file, so
# we gonna minify it to 300x300

require 'mini_magick'

image = MiniMagick::Image.open(file) # open a copy
image.resize '300x300'
image.write("#{file}min300")

puts 'Minification done'
# Fine!
return 0
