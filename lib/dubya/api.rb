require 'sinatra'
require 'sinatra/json'

module Dubya
  # A minimal API for updating the wiki on demand. This is the basic
  # controller of the entire application, facilitating GitHub Webhook
  # requests to the server. All it does is update the installed Wiki on
  # demand. The wiki is served using static HTML files.
  class API < Sinatra::Base
    set :views, "#{settings.root}/templates"

    get '/' do
      "Set up your wiki by running `rake setup`"
    end

    not_found do
      "File not found"
    end

    # Public: Update the wiki by checking out its latest changes from
    # GitHub and recompiling the HTML with Vim. Typically called by a
    # Webhook when the repository has been pushed to. While this is a
    # `POST` request, no parameters are necessary. It's merely a signal
    # to trigger the checkout and recompilation process.
    #
    # Returns 200 if the update succeeded, 500 if failed.
    post '/wiki' do
      flash = if Dubya.wiki.update
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
          errors: Dubya.wiki.command_output
        }
      end

      logger.debug Dubya.wiki.command_output

      status flash[:status]
      json flash
    end

    # Public: Edit a wiki page.
    put '/wiki/:page' do
      page = Dubya.wiki.find params[:page]
      raise Sinatra::NotFound if page.nil?
      page.update params[:content]
      redirect to("/#{page.name}.html")
    end

    # Public: Show the edit form for a wiki page.
    get '/wiki/:page' do
      page = Dubya.wiki.find params[:page]
      raise Sinatra::NotFound if page.nil?
      erb :form, locals: { page: page }
    end

    private

    def logger
      Dubya.logger
    end
  end
end
