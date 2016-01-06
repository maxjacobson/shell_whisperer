require "shell_whisperer/version"
require "English"

module ShellWhisperer
  class CommandFailed < StandardError; end

  def self.run(cmd)
    `#{cmd} 2>&1`.tap do |result|
      raise CommandFailed, result unless $CHILD_STATUS.success?
    end
  end
end
