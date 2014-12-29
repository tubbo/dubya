$LOAD_PATH << File.expand_path('../', __FILE__)

require 'dubya/wiki'
require 'dubya/api'

# Serves your Vimwiki as a Rack application.
module Dubya
  # Public: Root dir of the app.
  #
  # Returns a fully-qualified path to the app on disk.
  def self.root_path
    @root_path ||= File.expand_path '../', __FILE__
  end

  # Public: The object we use to represent the wiki on disk.
  #
  # Returns a Wiki object.
  def self.wiki
    @wiki ||= Wiki.new
  end
end
