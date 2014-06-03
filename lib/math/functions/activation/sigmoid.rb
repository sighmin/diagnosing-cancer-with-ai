class Intelligence::Math::Functions::Activation::Sigmoid  < Intelligence::Math::Functions::Activation::ActivationFunction

  def initialize options = {}
    @lambda = options[:lambda] || 1.0
    @gamma  = options[:gamma] || 1.0
    @offset = options[:offset] || 0.0
  end

  def activate input
    @gamma / (1.0 + Math.exp(-1.0 * @lambda * (input - @offset)))
  end

  def upper_limit; 1.0; end
  def lower_limit; 0.0; end
end
