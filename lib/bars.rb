require 'yaml'

class Bars
  def initialize(options={})
    file_path = options.delete(:file_path) { '~/bars.yml' }
    @timeframes = YAML.load(File.open(File.expand_path(file_path)))
  end

  def print(options={})
    print_mode = options.delete(:print_mode) { 'bars' }
    line_width = options.delete(:line_width) { 20 } - 1

    puts
    @timeframes.each do |timeframe, tasks|
      puts " #{timeframe.capitalize} ".center(30, "*")
      tasks.each do |task, done, goal|
        done_percent = (done.to_f/goal)
        if print_mode == 'percent'
          left_side = "#{task}:".ljust(line_width)
          right_side = "#{(done_percent * 100).floor}%".rjust(4)
          puts "--> #{left_side}#{right_side}"
        else
          puts "--> #{task}:"
          done_string = "+" * (done_percent * line_width)
          todo_string = "-" * (line_width - done_string.length)
          if done == 0
            splitter = '-'
          elsif done == goal
            splitter = '+'
          else
            splitter = '|'
          end
          puts "    |#{done_string}#{splitter}#{todo_string}|"
        end
      end
      puts
    end
  end
end
