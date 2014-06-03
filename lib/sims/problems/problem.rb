class Intelligence::Sims::Problems::Problem
  attr_accessor :objective

  def initialize options
    @objective = options[:objective] || :minimization
  end

  def fitness solution
    fail "not implemented yet".red
  end
end
