class Intelligence::Algo::Algorithm
  attr_accessor :problem, :iterations, :best_solution

  def initialize options
    fail "not implemented yet".red
  end

  def iterate
    fail "not implemented yet".red
  end

  def best_fitness
    @problem.fitness(@best_solution)
  end
end
