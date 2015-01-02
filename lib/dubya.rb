$LOAD_PATH << File.expand_path('../', __FILE__)

require 'dubya/wiki'
require 'dubya/api'
require 'logger'

# Serves your Vimwiki as a Rack application.
module Dubya
  def self.logger
    @logger ||= Logger.new STDOUT
  end

  # Public: Root dir of the app.
  #
  # Returns a fully-qualified path to the app on disk.
  def self.root_path
    @root_path ||= File.expand_path '../../', __FILE__
  end

  # Public: The object we use to represent the wiki on disk.
  #
  # Returns a Wiki object.
  def self.wiki
    @wiki ||= Wiki.new
  end

  def self.username
    ENV['DUBYA_USERNAME'] || 'admin'
  end

  def self.password
    ENV['DUBYA_PASSWORD'] || 'admin'
  end

  def self.cloned?
    File.exist? 'vendor/wiki/.git/HEAD'
  end
end
