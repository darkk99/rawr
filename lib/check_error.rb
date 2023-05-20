require 'colorize'

def check_error(res, list)
    abort 'An unknown error occurred' if res.is_a?(Net::HTTPError)
    abort "#{'error:'.bold.red} #{list['error']}" if list['type'] == 'error'
end
