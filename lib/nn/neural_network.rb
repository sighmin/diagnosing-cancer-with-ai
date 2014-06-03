class Intelligence::Nn::NeuralNetwork
  attr_accessor :layers, :config, :builder

  def initialize options
    @config = options[:layers]
    @builder = Intelligence::Nn::ArchitectureBuilder.new
    @layers = builder.build @config
  end

  def weights= weights
    @layers[1].set_weights(weights, @layers[0].layer_size())
  end

  def weights
    @layers[1].get_weights
  end

  def output pattern
    input_pattern = pattern.take(pattern.length-1)
    input_pattern += [-1] if @layers[0].bias?
    @layers[1].output(input_pattern)
  end

  def classify pattern
    pattern += [-1] if @layers[0].bias?
    out = @layers[1].output(pattern)
    if out <= 0.2
      "Malignant"
    elsif out >= 0.8
      "Benign"
    else
      out < 0.5 ? "Not definitive, but more likely Malignant" : "Not definitive, but more likely Benign"
    end
  end

  def to_s
    string = ""
    longest = layers.map{ |l| l.neurons.length }.max
    layers.each do |layer|
      buffer = ((longest - layer.neurons.length) / 2)
      string << "  " * buffer
      layer.neurons.each do |neuron|
        string << "* ".blue
      end
      string += "\n"
      string << "  " * buffer
      (layer.neurons.length-1).times do |i|
        string << " x"
      end
      string += "\n"
    end
    string
  end

  def to_file filepath
    store = PStore.new(filepath)
    store.transaction do
      store[:neural_network] = self
      store.commit
    end
  end

  def self.from_file filepath
    nn = nil
    store = PStore.new(filepath)
    store.transaction do
      nn = store[:neural_network]
      store.commit
    end
    nn
  end

end
