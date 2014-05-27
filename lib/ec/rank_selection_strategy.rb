class Intelligence::Ec::RankSelectionStrategy < Intelligence::Ec::SelectionStrategy

  def select entities, population
    # Calculate, form array of tuple to keep a reference to rank & entity
    normalized_ranks = calc_normalized_ranks(entities)
    tuples = []
    entities.each_with_index{ |e, i| tuples << [e, normalized_ranks[i]] }
    tuples.sort!{ |a,b| a[1] <=> b[1] }

    # Select probabilistically based on rank
    size = population
    selected = []
    while selected.length < size
      tuples.each_with_index do |tuple, index|
        if rand() < tuple[1]
          selected << tuples[index][0]
        end
      end
    end
    selected
  end

  def calc_normalized_ranks entities
    # Rank by fitness
    fitnesses = entities.map{ |e| e.fitness }
    sum = fitnesses.reduce(:+).to_f
    # Map the difference from the sum to favour smaller fitnesses (minimization)
    ranks = fitnesses.map{ |f| (sum-f).to_f/sum }
    # Calculate normalized array with ranks
    inverted_sum = ranks.reduce(:+).to_f
    ranks.map{ |r| r.to_f/inverted_sum }
  end

end
