require 'yaml'

class Bars
  def initialize(options={})
    file_path = options.delete(:file_path) { '~/bars.yml' }
    @timeframes = YAML.load(File.open(File.expand_path(file_path)))
  end

  def print(options={})
    line_width = options.delete(:line_width) { 25 } - 1

    puts
    @timeframes.each do |timeframe, tasks|
      tasks.each do |task, done, goal|
        percent = (done.to_f/goal)
        count = (percent * line_width.to_f).round
        done_string = "█" * (count)
        todo_string = "┅" * (line_width - count)
        percent_string = sprintf("%.1f%", (percent * 100)).rjust(6)
        goal_string = "#{done}/#{goal}".rjust(7)
        puts "#{task.ljust(line_width - 7)}#{goal_string}"
        puts "#{done_string}#{todo_string}#{percent_string}"
      end
      puts
    end
  end
end
