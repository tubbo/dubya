require 'mixlib/shellout'

class Wiki
  def update
    perform && updated?
  end

  def path
    File.join Dubya.root_path, 'vendor/wiki'
  end

  def updated?
    command.success?
  end

  def exist?
    Dir.exist? File.join(path, '.git/HEAD')
  end
  alias exists? exist?

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
    "cd #{Dubya.root} && bundle exec rake update"
  end

  def perform
    command.run_command
    true
  end
end
