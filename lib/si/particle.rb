class Intelligence::Si::Particle < Intelligence::Algo::Entity
  attr_accessor :algorithm, :pbest, :w, :c1, :c2, :position, :velocity, :fitness

  def initialize options
    @algorithm = options[:algorithm]
    @w = options[:w]
    @c1 = options[:c1]
    @c2 = options[:c2]
    @dimensions = options[:dimensions]
    init
  end

  def init
    @position = []
    @pbest = []
    @velocity = []
    @dimensions.times do |d|
      pos = rand(-1.0..1.0)
      @position << pos
      @pbest << pos
      @velocity << rand(-0.1..0.1)
    end
  end

  def update_velocity
    r1, r2 = rand(), rand()
    adjusted_velocity  = Intelligence::Math::VectorMath.mult_scalar(@w, @velocity)
    adjusted_cognitive = Intelligence::Math::VectorMath.mult_scalar(r1 * @c1, Intelligence::Math::VectorMath.minus(@pbest, @position))
    adjusted_social    = Intelligence::Math::VectorMath.mult_scalar(r2 * @c2, Intelligence::Math::VectorMath.minus(algorithm.best_solution.position, @position))

    @velocity = Intelligence::Math::VectorMath.add(adjusted_velocity, Intelligence::Math::VectorMath.add(adjusted_social, adjusted_cognitive))
  end

  def update_position
    @position = Intelligence::Math::VectorMath.add(@position, @velocity)
  end

  def update_pbest
    if algorithm.problem.fitness(@position) < algorithm.problem.fitness(@pbest)
      @pbest = @position.dup
    end
  end

  def <=> other
    @fitness <=> other.fitness
  end

  def calc_fitness
    @fitness = @algorithm.problem.fitness(@position)
  end
end
