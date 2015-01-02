require 'mixlib/shellout'
require 'dubya/wiki/page'

module Dubya
  # A model object representing the Git-tracked Vimwiki on disk. Also
  # used to run update and recompile commands against it.
  class Wiki
    def compile!
      Dubya.logger.info "Compiling Wiki files to HTML..."
      system 'vim vendor/wiki/index.wiki +VimwikiAll2HTML +qall'
    end

    # Public: A short redirection to Dubya::Wiki::Page
    def find(page)
      Page.find(page)
    end

    # Public: Commit everything with this message.
    def commit(message)
      Dubya.logger.info "Updating Git repository..."
      system %(cd #{path} && git commit -am "#{message}" && git push)
    end

    # Public: Update this repo.
    #
    # Returns `true` if updated.
    def update
      perform && updated?
    end

    # Public: A path to this repo on disk.
    #
    # Returns a fully-qualified path to the Vimwiki.
    def path
      File.join Dubya.root_path, 'vendor/wiki'
    end

    # Public: Tests if the command succeeded
    #
    # Returns `true` if the command was a success.
    def updated?
      command.success?
    end

    # Public: Tests if there is actually a Git repo in the path.
    #
    # Returns `true` if the .git/HEAD file is found within our path.
    def exist?
      File.exist? File.join(path, '.git/HEAD')
    end
    alias exists? exist?

    # Public: All output from the `Mixlib::ShellOut` command.
    #
    # Returns the STDOUT and STDERR separated by a double line break.
    def command_output
      [command.stdout, command.stderr].join("\n\n")
    end

    private

    # Internal: The command to the wiki right now and return results.
    #
    # Returns a Mixlib::ShellOut command waiting to be executed.
    def command
      @command ||= Mixlib::ShellOut.new from_instructions
    end

    # Internal: The actual shell command used to update the repo.
    #
    # Returns a String containing the shell command.
    def from_instructions
      "cd #{Dubya.root_path} && bundle exec rake update"
    end

    def perform
      command.run_command
      true
    end
  end
end
