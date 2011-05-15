require 'yaml'

class Bars
  def initialize(args=[])
    if !args.empty? && args.first == '-p'
      @print_mode = :percentage
    else
      @print_mode = :bars
    end

    @timeframes = YAML.load(File.open(File.expand_path('~/bars.yml')))
  end

  def print
    puts
    @timeframes.each do |timeframe, tasks|
      puts " #{timeframe.capitalize} ".center(30, "*")
      tasks.each do |task, done, goal|
        if @print_mode == :percentage
          puts "--> #{task}: #{(done.to_f/goal * 100).round}%"
        else
          puts "--> #{task}:"
          done_count = (done.to_f/goal * 20).to_i
          todo_count = 20 - done_count
          puts "    |#{"+" * (done_count)}|#{"-" * todo_count}|"
        end
      end
      puts
    end
  end
end
