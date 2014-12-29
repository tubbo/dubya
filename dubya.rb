require 'sinatra'
require 'sinatra/json'
require 'mixlib/shell_out'

# A minimal API for updating the wiki on demand. This is the basic
# controller of the entire application, facilitating GitHub Webhook
# requests to the server. All it does is update the installed Wiki on
# demand.
class Dubya < Sinatra::Base
  set :static, false

  # Public: Update the wiki.
  #
  # Examples
  #
  #     POST /wiki { ... }
  #
  # Returns 200 if the update succeeded, 500 if failed.
  post '/wiki' do
    flash = if wiki_updated?
      { notice: 'The wiki has been updated.' ,  status: 200 }
    else
      { alert: 'Error updating wiki.',          status: 422 }
    end

    json flash, status: flash[:status]
  end

  private

  # Internal: Update the wiki right now and return results.
  #
  # Returns `true` if the command(s) succeed, and `false` if any one of
  # them fails.
  def wiki_updated?
    system "cd #{wiki_path} && bundle exec rake update"
  end

  # Internal: The directory where the wiki is stored.
  #
  # Returns a fully-qualified path to the Wiki's repo on disk.
  def wiki_path
    File.expand_path './public', __FILE__
  end
end
