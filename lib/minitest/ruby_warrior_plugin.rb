module Minitest
  def self.plugin_ruby_warrior_init(options)
    if defined?(RubyWarrior::Runner)
      require_relative "ruby_warrior_summary_reporter"
      self.reporter.reporters.pop
      self.reporter << RubyWarriorSummaryReporter.new
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


    private
    def level_score
      match_data = /^Level Score: (?<score>\d+)$/.match(rw_output)
      return match_data.nil? ? 0 : match_data[:score].to_i
    end

    def time_bonus
      match_data = /^Time Bonus: (?<bonus>\d+)$/.match(rw_output)
      return match_data.nil? ? 0 : match_data[:bonus].to_i
    end

    def clear_bonus
      match_data = /^Clear Bonus: (?<bonus>\d+)$/.match(rw_output)
      return match_data.nil? ? 0 : match_data[:bonus].to_i
    end

    def total_score
      match_data = /^Total Score.*= (?<score>\d+)$/.match(rw_output)
      return match_data.nil? ? 0 : match_data[:score].to_i
    end
  end
end



