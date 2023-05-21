#!/usr/bin/bundle exec ruby
require 'colorize'
if ARGV.empty? then abort "#{'error:'.bold.red} rawr requires an argument" end

Dir["lib/*"].each do |file|
  require_relative file
end

command = ARGV.shift(1)[0][0, 1] # first letter of command
args = ARGV.join(' ')
if command == 's'
  if ARGV.include?('--quiet') then quiet = true else quiet = false end
  search(args, quiet)
elsif command == 'i'
  install(args)
elsif command == 'q' || command == 'l'
  query(args, quiet)
elsif command == 'r'
  remove(args)
end
