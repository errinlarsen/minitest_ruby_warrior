require_relative "../minitest_ruby_warrior/runner"

module Minitest
  class RubyWarriorSummaryReporter < SummaryReporter
    include MinitestRubyWarrior::Runner

    def start
      io.puts "RubyWarrior run options: #{rw_cli_args.join(' ')}"
      io.puts "Results ..."

      run_ruby_warrior
      rw_output.each_line.with_index { |l,i| io.puts "#{"%4d" % i}.  #{l}" }

      io.puts
      io.puts

      super
    end

    def record(result)
      super
      io.puts "RubyWarrior::Runner was different" if result.rw_output != rw_output
    end
  end
end
