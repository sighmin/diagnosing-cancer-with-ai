class Intelligence::Sims::Simulator
  include Intelligence::Sims
  attr_reader(*SimulatorConfig::SUPPORTED)
  attr_accessor :solutions

  def initialize &block
    @solutions = []
    config = SimulatorConfig.new
    config.instance_eval(&block) if block_given?
    init config
  end

  def init config
    @problem   = config[:problem]   || Intelligence::Sims::Problem.new
    @algorithm = config[:algorithm] || Intelligence::Algo::Pso.new
    @algorithm.problem = @problem
    @simulation = default_simulation.merge(config[:simulation] || {})
  end

  def run
    start()
    @algorithm.iterations.times do |i|
      @solutions << @algorithm.iterate(i)
      if i % 50 == 0
        puts "# #{i} => #{@algorithm.best_fitness}"
      end
    end
    report()
  end

  def start
    puts '*** '.magenta + 'Simulator starting...'.blue
  end

  def report
    puts '*** '.magenta + 'Simulator complete'.blue
    puts 'Solution: ' + @algorithm.best_solution.to_s.green
    puts 'Fitness:  ' + @algorithm.best_fitness.to_s.green
  end

  def best_solution
    @algorithm.best_solution
  end

private

  def default_simulation
    { runs: 30 }
  end
end
