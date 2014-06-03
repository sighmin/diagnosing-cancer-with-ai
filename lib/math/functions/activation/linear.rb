class Intelligence::Math::Functions::Activation::Linear < Intelligence::Math::Functions::ActivationFunction

  def activate input
    input
  end

  def upper_limit; ::Float::INFINITY; end
  def lower_limit; ::Float::INFINITY * -1; end
end
