class Intelligence::Sims::Problems::NnTrainingProblem < Intelligence::Sims::Problems::Problem
  attr_accessor :dataset, :network

  def initialize options
    @dataset = Intelligence::Nn::Dataset.new(options[:dataset])
    @dataset.init
    @network = Intelligence::Nn::NeuralNetwork.new(options[:neural_network])
    @precision = options[:precision].to_f
  end

  def fitness solution
    # set weights to NN architecture
    @network.weights = solution
    # retrieve shuffled training data
    patterns = @dataset.training

    # calculate mse
    error = 0.0
    patterns.each do |pattern|
      error += ((@dataset.target_value(pattern.last) - @network.output(pattern)) ** 2.0)
    end

    mse = error / patterns.length.to_f
    mse
  end

end
