require 'rake'

# Dubya's shell tasks help configure the server and update Vimwiki
# repos.

desc "Set up a Git repo that we'll pull from to update the wiki"
task :setup do
  if File.exist? 'vendor/wiki/.git/HEAD'
    puts "You already have a Vimwiki installed to ./vendor/wiki"
  else
    puts "Enter the path on GitHub to your Vimwiki (without the .git), https://github.com/..."
    repo = STDIN.gets.chomp

    sh 'rm vendor/wiki/.keep'
    sh "git clone https://github.com/#{repo}.git vendor/wiki"
  end
end

desc "Purge the vendor/wiki directory."
task :clean do
  sh 'rm -rf vendor/wiki'
  sh 'git checkout HEAD vendor/wiki/.keep'
end

namespace :update do
  task :checkout do
    if File.exist? 'vendor/wiki/.git/HEAD'
      sh 'cd vendor/wiki && git pull --rebase origin master'
    else
      fail "Error: Please run `rake setup` before attempting to checkout the repo."
    end
  end

  task :compile do
    if File.exist? 'vendor/wiki/.git/HEAD'
      sh 'vim +VimwikiAll2HTML && mv vendor/wiki/**/*.html public/'
    else
      fail "Error: Please run `rake setup` before attempting to compile sources."
    end
  end
end

desc "Update the Vimwiki from its Git repo"
task :update => %w(update:checkout update:compile)

task :intro do
  puts "You will now be guided through the first-time setup for Dubya"
end

# Update and install the latest Vimwiki before running the HTTP server.
task :default => %w(intro setup update) do
  puts "Dubya has been installed! Run `./bin/dubya` to start the server."
end
