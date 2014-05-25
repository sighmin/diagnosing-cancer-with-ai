class Intelligence::Sims::Problem
  attr_accessor :objective

  def initialize options
    @objective = options[:objective] || :minimization
  end

  def fitness solution
    # Test fitness
    distances = []
    solution.each do |i|
      distances << (1.0 - solution[i]).abs
    end
    solution.length.to_f - distances.reduce(:+)
  end
end
