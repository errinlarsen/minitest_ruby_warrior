module Minitest
  module Assertions
    def assert_ruby_warrior_output_includes(obj, msg = nil)
      assert_includes(rw_output, obj, msg)
    end

    def refute_ruby_warrior_output_includes(obj, msg = nil)
      refute_includes(rw_output, obj, msg)
    end

    def assert_ruby_warrior_level_score_meets_or_beats(score)
      refute_nil (level_score = find_level_score), "Expected to find a Level score"
      assert_operator score, :<=, level_score
    end

    def assert_ruby_warrior_time_bonus_meets_or_beats(bonus)
      refute_nil (time_bonus = find_time_bonus), "Expected to find a Time bonus"
      assert_operator bonus, :<=, time_bonus
    end

    def assert_ruby_warrior_clear_bonus_meets_or_beats(bonus)
      refute_nil (clear_bonus = find_clear_bonus), "Expected to find a Clear bonus"
      assert_operator bonus, :<=, clear_bonus
    end

    def assert_ruby_warrior_total_score_meets_or_beats(score)
      refute_nil (total_score = find_total_score), "Expected to find a Total score"
      assert_operator score, :<=, total_score
    end

    private
    def find_level_score
      match_data = /^Level Score: (?<score>\d+)$/.match(rw_output)
      return match_data ? match_data[:score].to_i : nil
    end

    def find_time_bonus
      match_data = /^Time Bonus: (?<bonus>\d+)$/.match(rw_output)
      return match_data ? match_data[:bonus].to_i : nil
    end

    def find_clear_bonus
      match_data = /^Clear Bonus: (?<bonus>\d+)$/.match(rw_output)
      return match_data ? match_data[:bonus].to_i : nil
    end

    def find_total_score
      match_data = /^Total Score.*= (?<score>\d+)$/.match(rw_output)
      return match_data ? match_data[:score].to_i : nil
    end
  end
end
