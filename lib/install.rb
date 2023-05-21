require 'colorize'
require 'net/http'
require 'git'
require 'pathname'

def install(package)
  res = Net::HTTP.get_response(URI("https://aur.archlinux.org/rpc/?v=5&type=info&arg[]=#{package}"))
  abort "#{'error:'.red.bold} target not found: #{package}" if res.body.include? '"resultcount":0,"results":[],'
  install_dir = "/tmp/rawr/#{package}"

  if !Dir.exists?('/tmp/rawr')
    puts 'Making directory `/tmp/rawr`...'
    Dir.mkdir('/tmp/rawr')
  elsif Dir.exists?(install_dir)
    puts "Removing previous directory #{install_dir}..."
    Pathname.new(install_dir).expand_path.rmtree
  end

  puts "Cloning into #{install_dir}..."
  Git.clone("https://aur.archlinux.org/#{package}.git", install_dir)

  print "Would you like to read the PKGBUILD? [#{'Y'.green}/#{'n'.red}] "
  if !STDIN.gets.chop.casecmp?('n')
    success = system("less #{install_dir}/PKGBUILD")
    abort "#{'error:'.bold.red} an unknown error occurred" if success == false

    print "Install package? [#{'Y'.green}/#{'n'.red}] "
    if !STDIN.gets.chop.casecmp?('n')
      puts "Checking for updates..."
      system("sudo pacman -Syu")
      puts "Running \`makepkg -si\`"
      success = system("cd #{install_dir} && makepkg -si")
      abort "#{'error:'.bold.red} an unknown error occurred" if success == false
    end
  end

end


