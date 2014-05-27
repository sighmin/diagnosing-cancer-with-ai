class Intelligence::Ec::RandomSelectionStrategy < Intelligence::Ec::SelectionStrategy

  def select entities, population
    # Select probabilistically based on rank
    selected = []
    population.times do |i|
      selected << entities.sample
    end
    selected
  end

end
