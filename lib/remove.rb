def remove(package)
  success = system("sudo pacman -R #{package}")
  abort "#{'error:'.bold.red} An error occurred" if success == false
end
