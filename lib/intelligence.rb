require 'intelligence/version'
require 'pry'
require 'colorize'
require 'active_support/all'

module Utils
  def self.relative_path file
    File.expand_path(File.join('../', file), __FILE__)
  end
end

module Intelligence
  module Sims
    autoload :Simulator,       Utils.relative_path('sims/simulator')
    autoload :SimulatorConfig, Utils.relative_path('sims/simulator_config')
    autoload :Simulation,      Utils.relative_path('sims/simulation')
    autoload :Solution,        Utils.relative_path('sims/solution')
    autoload :Problem,         Utils.relative_path('sims/problem')
  end
  module Algo
    autoload :Algorithm,       Utils.relative_path('algo/algorithm')
    autoload :Entity,          Utils.relative_path('algo/entity')
    autoload :Pso,             Utils.relative_path('algo/pso')
  end
  module Si
    autoload :Particle,        Utils.relative_path('si/particle')
  end
  module Math
    autoload :VectorMath,      Utils.relative_path('math/vector_math')
  end

  class << self
    def test
      puts "Intelligence gem version #{Intelligence::VERSION}"
    end
  end
end
