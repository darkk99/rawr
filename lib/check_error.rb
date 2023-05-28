require 'colorize'

def check_error(res, list)
    abort "#{'error:'.bold.red} An HTTP error occurred" unless res.is_a?(Net::HTTPSuccess) 
    abort if list['type'] == 'error'
end