#!/usr/bin/bundle exec ruby
require_relative 'lib/search.rb'
require_relative 'lib/install.rb'

command = ARGV.shift(1)[0][0, 1] # first letter of command
args = ARGV.join(' ')
if command == 's'
  if ARGV.include?('--quiet') then quiet = true else quiet = false end
  search(args, quiet)
elsif command == 'i'
  install(args)
end
