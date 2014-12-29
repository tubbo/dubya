require 'rake'

desc "Set up a Git repo that we'll pull from to update the wiki"
task :setup do
  unless File.exist? 'vendor/wiki/.git/HEAD'
    puts "Enter the path on GitHub to your Vimwiki (without the .git):\s https://github.com/"
    repo = STDIN.gets.chomp

    sh 'rm vendor/wiki/.keep'
    sh "git clone https://github.com/#{repo}.git vendor/wiki"
  end
end

namespace :update do
  task :checkout do
    sh 'cd vendor/wiki && git pull --rebase origin master'
  end

  task :compile do
    sh 'vim +VimwikiAll2HTML && mv vendor/wiki/**/*.html public/'
  end
end

desc "Update the Vimwiki from its Git repo"
task :update => %w(update:checkout update:compile)

# Update and install the latest Vimwiki before running the HTTP server.
task :default => %w(update install server)
