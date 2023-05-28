require 'colorize'
require 'json'
require 'net/http'
require 'git'
require_relative 'check_error.rb'

def info(package)
  return "#{'error:'.bold.red} \`info\` requires an argument" if package.delete(' ') == ''
  
  uri = URI('https://aur.archlinux.org/rpc/')
  params = {
    :v => 5,
    :type => 'info',
    :arg => package,
  }
  uri.query = URI.encode_www_form(params).sub('&arg=', '&arg[]=')
  puts uri.query
  
  res = Net::HTTP.get_response(uri)
  list = JSON.parse(res.body)
  puts res.body
  check_error(res, list)
  return '' if list['resultcount'] == 0

  
end