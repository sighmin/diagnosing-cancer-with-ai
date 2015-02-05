class Intelligence::Algo::Pso < Intelligence::Algo::Algorithm
  @@best_classification = 0
  @@best_weights = nil

  def initialize options
    @iterations = options[:iterations] || 1000
    @w = options[:w] || 0.729844
    @c1 = options[:c1] || 1.496180
    @c2 = options[:c2] || 1.496180
    @dimensions = options[:dimensions] || 5
    @population = options[:population] || 30
    @domain = options[:domain] || (-0.5..0.5)
    @vdomain = options[:vdomain] || (-0.5..0.5)
    particle_options = {
      w: @w,
      c1: @c1,
      c2: @c2,
      dimensions: @dimensions,
      domain: @domain,
      vdomain: @vdomain,
      algorithm: self
    }
    @swarm = initialize_swarm(@population, particle_options)
    @best_solution = @swarm.sample.dup
  end

  def initialize_swarm population, particle_options
    population.times.map do |i|
      Intelligence::Si::Particle.new particle_options
    end
  end

  def iterate i
    @swarm.each do |particle|
      particle.update_velocity
      particle.update_position
      particle.update_pbest
      update_gbest particle
    end
  end

  def update_gbest candidate
    @swarm.each{ |particle| particle.calc_fitness }
    @best_solution.calc_fitness
    if candidate.fitness < @best_solution.fitness
      @best_solution = candidate.dup
    end

    # Also update best_weights
    best_solution_classification = @problem.classification(@best_solution.position)
    if best_solution_classification > @@best_classification
      @@best_classification = best_solution_classification
      @@best_weights = @best_solution.position
    end
  end

  def best_fitness_to_print
    best_fitness.to_s
  end

  def best_solution_to_print
    @best_solution.position.to_s
  end

  def best_weights_to_print
    @@best_weights.to_s
  end

  def best_fitness
    @problem.fitness(@best_solution.position)
  end

  def best_generalization
    @problem.generalization(@best_solution.position)
  end

  def best_classification
    @problem.classification(@best_solution.position)
  end

  def measurements
    [ best_fitness, best_generalization, best_classification ]
  end

  def attributes_to_persist
    [ @@best_classification, @@best_weights ]
  end
end
