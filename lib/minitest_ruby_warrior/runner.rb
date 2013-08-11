require "stringio"
require "ruby_warrior"

module MinitestRubyWarrior
  module Runner
    attr_reader :rw_runner, :rw_output
    alias_method :ruby_warrior_runner, :rw_runner
    alias_method :ruby_warrior_output, :rw_output

    def run_ruby_warrior
      stdin  = StringIO.new; stdout = StringIO.new
      @rw_runner = RubyWarrior::Runner.new(rw_cli_args, stdin, stdout)
      @rw_runner.run
      @rw_output = stdout.string
    end


    private
    def rw_cli_args
      return %w[-d rubywarrior/irken1-beginner -s -t 0]
    end
  end
end
