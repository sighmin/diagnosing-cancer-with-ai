class Intelligence::Sims::Simulator
  include Intelligence::Sims
  attr_reader(*SimulatorConfig::SUPPORTED)

  def initialize &block
    config = SimulatorConfig.new
    config.instance_eval(&block) if block_given?
    init(config)
  end

  def init config
    @algorithm = config[:algorithm] || :pso
    @problem   = config[:problem] || :minimization
  end

  def run
    puts 'running'
  end
end
