require "shell_whisperer/version"
require "English"

module ShellWhisperer
  class CommandFailed < StandardError
    def initialize(cmd, result, exit_code)
      super "Attempted to run #{cmd.inspect} but the shell reported error: " \
            "#{result.chomp.inspect} and exited with exit code #{exit_code}."
    end
  end

  def self.run(cmd)
    `#{cmd} 2>&1`.tap do |result|
      unless $CHILD_STATUS.success?
        raise CommandFailed.new(cmd, result, $CHILD_STATUS.exitstatus)
      end
    end
  end
end
