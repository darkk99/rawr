require 'net/http'
require 'json'
require 'date'
require 'colorize'

def check_error(res, list)
    abort "#{"error:'.bold.red} An error occurred' if res.is_a?(Net::HTTPError)
    abort "#{'error:'.bold.red} An error occurred" if res.is_a?(Net::HTTPError)
    abort "#{'error:'.bold.red} #{list['error']}" if list['type'] == 'error'
end

def search(package, quiet=false)
  return 'error: `search` requires an argument' if package.delete(' ') == ''
  package.slice!('--quiet') if package.include? '--quiet'
  uri = URI('https://aur.archlinux.org/rpc/')
  params = {
    :v => 5,
    :type => 'search',
    :arg => package,
  }
  uri.query = URI.encode_www_form(params)

  res = Net::HTTP.get_response(uri)

  list = JSON.parse(res.body)

  check_error(res, list)
  return '' if list['resultcount'] == 0

  (0..(list['resultcount'] - 1)).each do |i|
    current_item = list['results'][i]
    print current_item['Name']
    if quiet == true
      puts
    else
     print ' ' + current_item['Version']
     if current_item['OutOfDate'] != nil
       puts " [Out of Date: #{Time.at(current_item['OutOfDate'])}]".red.bold
     else
       puts
     end
     puts '    ' + current_item['Description'] if current_item['Description'] != nil
    end
  end
end
