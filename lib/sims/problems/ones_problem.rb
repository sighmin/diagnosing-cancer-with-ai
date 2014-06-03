class Intelligence::Sims::Problems::OnesProblem < Intelligence::Sims::Problems::Problem

  def fitness solution
    # Test fitness
    distances = []
    solution.each_index do |i|
      distances << (1.0 - solution[i]).abs
    end
    distances.reduce(:+)
  end

end
