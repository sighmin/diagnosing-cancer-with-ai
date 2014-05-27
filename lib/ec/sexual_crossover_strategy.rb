class Intelligence::Ec::SexualCrossoverStrategy < Intelligence::Ec::CrossoverStrategy

  def crossover individuals
    crossed_over = []
    individuals.each do |individual|
      crossed_over << recombine(individual, individuals.sample)
    end
    crossed_over
  end

  def recombine father, mother
    father_dna = father.chromosome.dup
    mother_dna = mother.chromosome.dup
    offspring = []
    father.chromosome.each_with_index do |gene, i|
      if rand() < @probability
        offspring << mother_dna[i]
      else
        offspring << father_dna[i]
      end
    end
    clone = father.dup
    clone.chromosome = offspring
    clone
  end

end
