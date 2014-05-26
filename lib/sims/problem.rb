class Intelligence::Sims::Problem
  attr_accessor :objective

  def initialize options
    @objective = options[:objective] || :minimization
  end

  def fitness solution
    # Test fitness
    distances = []
    solution.each_index do |i|
      distances << (1.0 - solution[i]).abs
    end
    distances.reduce(:+)
  end
end
