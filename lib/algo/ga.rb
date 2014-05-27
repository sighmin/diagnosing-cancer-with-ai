class Intelligence::Algo::Ga < Intelligence::Algo::Algorithm

  def initialize options
    @generations = @iterations = options[:iterations] || 1000
    @dimensions = options[:dimensions] || 5
    @population = options[:population] || 30
    individual_options = {
      dimensions: @dimensions,
      algorithm: self
    }
    @selection_strategy = Object.const_get("Intelligence::Ec::#{options[:selection_strategy].to_s.camelize}").new
    @crossover_strategy = Intelligence::Ec::SexualCrossoverStrategy.new(probability: options[:crossover_rate])
    @mutation_strategy  = Intelligence::Ec::MutationStrategy.new(probability: options[:mutation_rate])
    @individuals = initialize_population(@population, individual_options)
    @best_solution = @individuals.sample.dup
  end

  def initialize_population population, individual_options
    population.times.map do |i|
      Intelligence::Ec::Individual.new individual_options
    end
  end

  def iterate i
    # Calculate fitness
    @individuals.each{ |individual| individual.calc_fitness }

    # Recombine
    offspring = @crossover_strategy.crossover(@individuals)

    # Mutate
    mutated_offspring = @mutation_strategy.mutate(offspring, problem)

    # Select next generation
    generation_pool = (@individuals + mutated_offspring)
    generation_pool.each{ |individual| individual.calc_fitness }
    new_population = @selection_strategy.select(generation_pool, @population)

    # Ensure elitism
    @individuals = elitism(new_population, generation_pool)

    @best_solution
  end

  def elitism new_population, generation_pool
    generation_pool.each{ |individual| individual.calc_fitness }
    fittest = generation_pool.first
    generation_pool.each do |individual|
      fittest = individual if individual.fitness < fittest.fitness
    end

    @best_solution = fittest.dup
    new_population[rand(0...new_population.length)] = fittest
    new_population
  end

  def best_fitness
    @problem.fitness(@best_solution.chromosome)
  end

  def best_fitness_to_print
    best_fitness.to_s
  end

  def best_solution_to_print
    @best_solution.chromosome.join.to_s
  end
end
