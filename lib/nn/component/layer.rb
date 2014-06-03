class Intelligence::Nn::Component::Layer
  attr_accessor :neurons, :successor, :bias

  def initialize options = {}
    @size = options[:size]
    @bias = options[:bias]
    function = options[:function] ? Object.const_get("Intelligence::Math::Functions::Activation::#{options[:function].to_s.camelize}").new : nil

    @neurons = []
    @size.times do |i|
      @neurons << Intelligence::Nn::Component::Neuron.new(function: function)
    end
    @neurons << Intelligence::Nn::Component::BiasNeuron.new(function: function) if @bias
  end

  def bias?
    @bias
  end

  def layer_size
    @neurons.length
  end

  def set_weights weights, neuron_size
    remaining_weights = weights
    @neurons.each do |neuron|
      next if neuron.is_a?(Intelligence::Nn::Component::BiasNeuron)
      neuron_weights    = remaining_weights.take(neuron_size)
      remaining_weights = remaining_weights.drop(neuron_size)
      neuron.set_weights(neuron_weights)
    end

    successor.set_weights(remaining_weights, layer_size()) if successor
  end

  def get_weights
    weights = []
    @neurons.each do |neuron|
      next if neuron.is_a?(Intelligence::Nn::Component::BiasNeuron)
      weights += neuron.weights.dup
    end
    weights += successor.get_weights if successor
    weights
  end

  def output pattern
    if !successor
      # return output of layer if no successor
      sum = 0.0
      @neurons.each do |neuron|
        o = neuron.output(pattern)
        sum += o
      end
      sum
    else
      # add bias to pattern if bias
      next_pattern = []
      @neurons.each do |neuron|
        next_pattern << neuron.output(pattern)
      end
      next_pattern += [-1] if bias?
      # send pattern to next layer
      successor.output(next_pattern)
    end
  end
end
