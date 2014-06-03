class Intelligence::Nn::ArchitectureBuilder

  def build layers_config
    layers = []
    # Create layers
    layers_config.each do |config|
      layer = Intelligence::Nn::Component::Layer.new(config)
      layers << layer
    end
    # Setup chain of responsibility
    layers.each_index do |i|
      layers[i].successor = layers[i + 1]
    end
    layers.last.successor = nil

    layers
  end

end
