class Intelligence::Ec::Individual < Intelligence::Algo::Entity
  attr_accessor :fitness, :chromosome

  def initialize options
    @algorithm = options[:algorithm]
    @dimensions = options[:dimensions]
    init
  end

  def init
    @chromosome = []
    @dimensions.times do |d|
      @chromosome << Intelligence::Sims::Problems::HelloWorldProblem::ALPHA.sample
    end
  end

  def calc_fitness
    @fitness = @algorithm.problem.fitness(@chromosome)
  end

  # This is probably wildly inefficient :/
  def dup
    duplicate = Intelligence::Ec::Individual.new({
      algorithm: @algorithm,
      dimensions: @dimensions
    })
    duplicate.chromosome = @chromosome.dup
    duplicate.fitness    = @fitness
    duplicate
  end
end
