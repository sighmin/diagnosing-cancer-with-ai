class Intelligence::Nn::Component::Neuron
  attr_accessor :activation_function, :weights, :output

  def initialize options = {}
    @activation_function = options[:function]
  end

  def set_weights weights
    @weights = weights.dup
  end

  def output pattern = nil
    @activation_function.activate(sum_of_products(pattern))
  end

  def is_bias?
    false
  end

private

  def sum_of_products pattern
    sum = 0.0
    @weights.each_index do |i|
      sum += (@weights[i] * pattern[i])
    end
    sum
  end
end
