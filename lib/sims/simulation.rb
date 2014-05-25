class Intelligence::Sims::Simulation < Hash
  def initialize options
    self[:run] = options[:run]
  end
end
