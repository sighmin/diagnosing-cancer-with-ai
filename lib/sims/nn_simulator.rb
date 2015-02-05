class Intelligence::Sims::NnSimulator < Intelligence::Sims::Simulator

  def run
    bootstrap()
    start()
    @algorithm.iterations.times do |i|
      @solutions << @algorithm.iterate(i)
      update(i)
      persist_weights()
    end
    persist()
    report()
  end

  def update i
    if i % @simulation[:resolution] == 0
      puts "# #{i} => #{measurements}"
    end
  end

  def bootstrap
    # training mse, generalization mse, generalization classification error %, NN object
    @best = [ 1.0, 0.0, 0.0, nil ]
  end

  def start
    puts '*** '.magenta + 'Neural Network Training Simulator starting'.blue
  end

  def report
    puts '*** '.magenta + 'Simulator complete'.blue
    puts 'Solution: ' + @algorithm.best_solution_to_print.green
    puts 'Fitness:  ' + @algorithm.best_fitness_to_print.green
    puts 'Weights:  ' + @algorithm.best_weights_to_print.green
  end

  def measurements
    m = @algorithm.measurements
    ["training: #{m[0]}", "generalization: #{m[1]}", "classification% : #{m[2]}"]
  end

  def persist
    store = PStore.new('nn.pstore')
    store.transaction do
      store[:training]       = @best[0]
      store[:generalization] = @best[1]
      store[:classification] = @best[2]
      store[:network]        = @best[3]
      store.commit
    end
  end

  def best_solution
    @algorithm.best_solution
  end

  def persist_weights
    if @algorithm.best_classification > @best[2]
      @best = @algorithm.measurements + [@problem.network]
    end
  end
end
