class Intelligence::Sims::Simulation < Hash
  def initialize options
    self[:runs] = options[:runs] || 1
    self[:resolution] = options[:resolution] || 50
  end
end
