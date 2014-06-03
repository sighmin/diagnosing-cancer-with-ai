class Intelligence::Sims::Problems::NnTrainingProblem < Intelligence::Sims::Problems::Problem
  attr_accessor :dataset, :network

  def initialize options
    @dataset = Intelligence::Nn::Dataset.new(options[:dataset])
    @dataset.init
    @network = Intelligence::Nn::NeuralNetwork.new(options[:neural_network])
    @precision = options[:precision].to_f
  end

  def fitness solution
    nn_error solution, @dataset.training
  end

  def generalization solution
    nn_error solution, @dataset.generalization
  end

  def classification solution
    @network.weights = solution
    # retrieve shuffled training data
    patterns = @dataset.generalization

    # calculate classification error against precision
    error = 0.0
    patterns.each do |pattern|
      error += precision_classification(pattern.last, @network.output(pattern))
    end
    error / patterns.length.to_f
  end

private

  def nn_error solution, patterns
    @network.weights = solution

    # calculate mse on data_partition
    error = 0.0
    patterns.each do |pattern|
      error += ((@dataset.target_value(pattern.last) - @network.output(pattern)) ** 2.0)
    end

    error / patterns.length.to_f
  end

  def precision_classification target, output
    difference = (@dataset.target_value(target) - output).abs
    if difference < @precision
      1.0
    else
      0.0
    end
  end

end
