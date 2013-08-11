module Minitest
  def self.plugin_ruby_warrior_init(options)
    if defined?(RubyWarrior::Runner)
      require_relative "ruby_warrior_assertions"
      require_relative "ruby_warrior_summary_reporter"
      self.reporter.reporters.pop
      self.reporter << RubyWarriorSummaryReporter.new
    end
  end
end
