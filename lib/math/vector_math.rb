class Intelligence::Math::VectorMath

  class << self
    def add v1, v2
      v1.zip(v2).map{ |z| z.inject(&:+) }
    end

    def minus v1, v2
      v1.zip(v2).map{ |z| z.inject(&:-) }
    end

    def mult_scalar scalar, vector
      vector.map{ |v| scalar * v }
    end
  end

end
