require 'colorize'
require 'net/http'
require 'git'
require 'pathname'

def install(package)

  res = Net::HTTP.get_response(URI("https://aur.archlinux.org/#{package}.git"))
  abort "#{'error:'.red.bold} package not found" if res.body.include?('404 - Page Not Found') && !res.body.include?('Git clone URLs are not meant to be opened in a browser.')

  if !Dir.exists?('/tmp/rawr')
    Dir.mkdir('/tmp/rawr')
  elsif Dir.exists?("/tmp/rawr/#{package}")
    Pathname.new("/tmp/rawr/#{package}").expand_path.rmtree
  end

  Git.clone("https://aur.archlinux.org/#{package}.git", "/tmp/rawr/#{package}")
end


