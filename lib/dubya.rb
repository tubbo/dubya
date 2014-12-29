$LOAD_PATH << File.expand_path('../', __FILE__)

require 'sinatra'
require 'sinatra/json'
require 'mixlib/shellout'
require 'wiki'

# = Dubya API
#
# A minimal API for updating the wiki on demand. This is the basic
# controller of the entire application, facilitating GitHub Webhook
# requests to the server. All it does is update the installed Wiki on
# demand. The wiki is served using static HTML files.
class Dubya < Sinatra::Base
  set :static, false

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

  # Public: Update the wiki by checking out its latest changes from
  # GitHub and recompiling the HTML with Vim. Typically called by a
  # Webhook when the repository has been pushed to. While this is a
  # `POST` request, no parameters are necessary. It's merely a signal
  # to trigger the checkout and recompilation process.
  #
  # Returns 200 if the update succeeded, 500 if failed.
  post '/wiki' do
    flash = if self.class.wiki.update
      logger.info "Wiki updated successfully."
      {
        notice: 'The wiki has been updated.',
        status: 200
      }
    else
      logger.warn "Couldn't update the wiki with an API call."
      {
        alert: 'Error updating wiki.',
        status: 422,
        errors: self.class.wiki.command_output
      }
    end

    logger.debug self.class.wiki.command_output

    status flash[:status]
    json flash
  end
end
