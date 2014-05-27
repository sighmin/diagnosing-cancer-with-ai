class Intelligence::Ec::MutationStrategy
  attr_accessor :probability

  def initialize options
    @probability = options[:probability] || 0.4
  end

  def mutate individuals, problem
    individuals.each do |individual|
      mutate_entity individual, problem
    end
    individuals
  end

  def mutate_entity individual, problem
    chromosome = individual.chromosome
    chromosome.each_index do |gene_index|
      if rand() < @probability
        chromosome[gene_index] = problem.mutate_gene(chromosome[gene_index])
      end
    end
  end

end
