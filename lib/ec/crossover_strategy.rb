class Intelligence::Ec::CrossoverStrategy
  attr_accessor :probability

  def initialize options
    @probability = options[:probability] || 0.6
  end

  def crossover individuals
    fail "not implemented yet".red
  end

end
