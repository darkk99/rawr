require 'colorize'

def query(arg, quiet = false)
  if arg == nil then arg = '' end

  if quiet == true
    $success == system("pacman -Qmq #{arg}")
  else
    $success == system("pacman -Qm #{arg}")
  end

  if $success == false then abort "#{'error'.bold.red}: An error occurred" end
end
