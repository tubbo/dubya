$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'rake'
require 'yard'
require 'yard-tomdoc'
require 'yard-sinatra'
require 'dubya'

# Dubya's shell tasks help configure the server and update Vimwiki
# repos.

def er(msg)
  puts "Error: #{msg}"
  exit 1
end

def wiki_cloned?
  File.exist? 'vendor/wiki/.git/HEAD'
end

desc 'Configure the Vimwiki that we will be serving'
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

desc 'Purge the vendor/wiki directory.'
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
  task :check do
    er 'Please run `rake setup` before attempting to update the repo.' unless wiki_cloned?
  end

  task :pull do
    sh 'cd vendor/wiki && git pull --rebase origin master'
  end

  task :compile do
    Dubya.wiki.compile!
  end
end

desc "Sync the Vimwiki from its Git repo and recompile HTML"
task :update => %w(update:check clean update:pull update:compile)

# Install documentation.
YARD::Rake::YardocTask.new :docs do |t|
  t.options = ['--readme=README.md', '--plugin=tomdoc']
  t.files = ['config.ru', 'lib/dubya.rb']
end

# Update and install the latest Vimwiki before running the HTTP server.
task :default => %w(setup update) do
  puts "Dubya has been installed! Run `./bin/dubya` to start the server."
end
