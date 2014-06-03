class Intelligence::Math::Functions::Activation::TanH  < Intelligence::Math::Functions::Activation::ActivationFunction

  def activate input
    a = Math.exp(input)
    b = Math.exp(-input)
    ((a - b) / (a + b))
  end

  def upper_limit; 1.0; end
  def lower_limit; -1.0; end
end
