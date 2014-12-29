$LOAD_PATH << File.expand_path('../', __FILE__)

require 'sinatra'
require 'sinatra/json'
require 'mixlib/shellout'
require 'wiki'
require 'dubya/api'
require 'dubya/wiki'

module Dubya
  # Public: Root dir of the app.
  #
  # Returns a fully-qualified path to the app on disk.
  def self.root_path
    File.expand_path '../', __FILE__
  end

  # Public: The object we use to represent the wiki on disk.
  #
  # Returns a Wiki object.
  def self.wiki
    @wiki ||= Wiki.new
  end
end
