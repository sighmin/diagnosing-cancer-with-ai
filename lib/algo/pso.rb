class Intelligence::Algo::Pso < Intelligence::Algo::Algorithm

  def initialize options
    @iterations = options[:iterations] || 1000
    @w = options[:w] || 0.729844
    @c1 = options[:c1] || 1.496180
    @c2 = options[:c2] || 1.496180
    @dimensions = options[:dimensions] || 5
    @population = options[:population] || 30
    particle_options = {
      w: @w,
      c1: @c1,
      c2: @c2,
      dimensions: @dimensions,
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
  end
end
