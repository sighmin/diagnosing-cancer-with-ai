class Intelligence::Nn::Component::BiasNeuron < Intelligence::Nn::Component::Neuron

  def output pattern
    -1.0
  end

  def is_bias?
    true
  end

end
