require 'rake'
require 'yard'
require 'yard-tomdoc'
require 'yard-sinatra'

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
task :reset do
  sh 'rm -rf vendor/wiki'
  sh 'git checkout HEAD vendor/wiki/.keep'
end

desc "Purge the public/ directory of all HTML files"
task :clean do
  sh 'rm -rf public/'
  sh 'git checkout HEAD public/'
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
      sh 'vim vendor/wiki/index.wiki +VimwikiAll2HTML +qall'
    else
      fail "Error: Please run `rake setup` before attempting to compile sources."
    end
  end
end

desc "Update the Vimwiki from its Git repo"
task :update => %w(update:checkout update:compile)

# Install documentation.
YARD::Rake::YardocTask.new :docs do |t|
  t.options = ['--readme=README.md', '--plugin=tomdoc']
  t.files = ['config.ru', 'lib/dubya.rb']
end

# Update and install the latest Vimwiki before running the HTTP server.
task :default => %w(setup update) do
  puts "Dubya has been installed! Run `./bin/dubya` to start the server."
end
