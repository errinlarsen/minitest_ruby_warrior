module Minitest
  module RubyWarrior
    module Runner
      attr_reader :rw_runner, :rw_output, :rw_error
      alias_method :ruby_warrior_runner, :rw_runner
      alias_method :ruby_warrior_output, :rw_output
      alias_method :ruby_warrior_error, :rw_error

      def run_ruby_warrior(klass = nil)
        unless it_acts_like_a_ruby_warrior_runner(klass)
          raise ArgumentException, "You must inject a RubyWarrior::Runner Class"
        end

        @rw_runner = klass.new(rw_cli_args, STDIN, STDOUT)
        @rw_output, @rw_error = capture_subprocess_io { rw_runner.run }
      end


      private
      def it_acts_like_a_ruby_warrior_runner(klass)
        it_is_a_class        = klass.is_a?(Class)
        its_new_needs_3_args = klass.instance_method(:initialize).arity == 3
        it_responds_to_run   = klass.instance_methods.include?(:run)

        return it_is_a_class && its_new_needs_3_args && it_responds_to_run
      end

      def rw_cli_args
        return %w[-d rubywarrior/irken1-beginner -s -t 0]
      end

      def level_score
        match_data = /^Level Score: (?<score>\d+)$/.match(rw_output)
        return match_data[:score].to_i
      end

      def time_bonus
        match_data = /^Time Bonus: (?<bonus>\d+)$/.match(rw_output)
        return match_data[:bonus].to_i
      end

      def clear_bonus
        match_data = /^Clear Bonus: (?<bonus>\d+)$/.match(rw_output)
        return match_data[:bonus].to_i
      end

      def total_score
        match_data = /^Total Score.*= (?<score>\d+)$/.match(rw_output)
        return match_data[:score].to_i
      end
    end
  end
end
