class Intelligence::Sims::Problems::HelloWorldProblem < Intelligence::Sims::Problems::Problem
  ALPHA = ('a'..'z').to_a + [" "]

  def fitness solution
    target = 'hello world'
    return nil unless solution.length == target.length
    solution.each_index.inject(0) do |sum, i|
      sum + char_distance(solution[i], target[i])
    end
  end

  def mutate_gene gene_index
    index = ALPHA.index(gene_index)
    index += rand() < 0.5 ? 1 : -1
    ALPHA[index % ALPHA.length].dup
  end

private

  def char_distance ai, bi
    ia = ALPHA.index(ai)
    ib = ALPHA.index(bi)
    diff = (ia-ib).abs
    forward  = diff
    backward = (diff - ALPHA.length).abs
    distance = forward < backward ? forward : backward
    distance
  end

end
