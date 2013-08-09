require_relative "../minitest_ruby_warrior/runner"

module Minitest
  def self.plugin_ruby_warrior_init(options)
    self.reporter.reporters.pop
    self.reporter << RubyWarriorSummaryReporter.new
  end

  class RubyWarriorSummaryReporter < SummaryReporter
    include MinitestRubyWarrior::Runner

    def start
      run_ruby_warrior
      puts ruby_warrior_output
      super
    end

    def record(result)
      super
      puts result.instance_variables.inspect
    end

    def report
      super
      puts self.results.inspect
    end
  end

  module Assertions
    def assert_ruby_warrior_output_includes(obj, msg = nil)
      assert_includes(rw_output, obj, msg)
    end

    def refute_ruby_warrior_output_includes(obj, msg = nil)
      refute_includes(rw_output, obj, msg)
    end

    def assert_ruby_warrior_level_score_meets_or_beats(score)
      assert_operator score, :<=, level_score
    end

    def assert_ruby_warrior_time_bonus_meets_or_beats(bonus)
      assert_operator bonus, :<=, time_bonus
    end

    def assert_ruby_warrior_clear_bonus_meets_or_beats(bonus)
      assert_operator bonus, :<=, clear_bonus
    end

    def assert_ruby_warrior_total_score_meets_or_beats(score)
      assert_operator score, :<=, total_score
    end
  end
end



